import Vapor
import PostgresKit
import NIO
import S3

final class ImageController {
    private let conn: DatabaseConnection
    private let s3: S3
    private let s3BucketName: String
    private let awsRegion: String
    private let s3PublicDomain :String

    init(conn: DatabaseConnection) {
        self.conn = conn
        self.s3BucketName = ProcessInfo.processInfo.environment["ENV"] == "production" ? "toolpool-prod" : "toolpool-dev"
        self.awsRegion = "us-west-1"
        self.s3 = S3(region: Region(rawValue: awsRegion))
        self.s3PublicDomain = "https://" + self.s3BucketName +  ".s3-" + self.awsRegion + ".amazonaws.com/"
    }
    
    func uploadImage(_ data: uploadBase64ImageHTTPBody, context: Context) throws -> EventLoopFuture<PostgresQueryResult> {
        let toolId = data.toolId
        let imageString = data.imageFile
        var contentType: String
        var imageType: String


        let parsedBase64 = imageString.components(separatedBy: "base64,")
        let base64MetaData = parsedBase64[0]
        let base64BodyData = parsedBase64[1]

        if let match = base64MetaData.range(of: "image\\/\\w+", options: .regularExpression) {
            contentType = base64MetaData.substring(with: match).components(separatedBy: "/")[0]
            imageType = base64MetaData.substring(with: match).components(separatedBy: "/")[1]
        } else {
            return self.conn.getDB().eventLoop.makeFailedFuture(Abort(.badRequest))
        }
        let imageBuffer = Data(base64Encoded: base64BodyData, options: .ignoreUnknownCharacters)!

        if imageType == "" {
            return self.conn.getDB().eventLoop.makeFailedFuture(Abort(.badRequest))
        }

        return conn.getDB().query("SELECT * FROM tools WHERE tool_id = $1", [PostgresData(int: toolId)])
        .flatMap{ result in
            let toolImageItem = result.first
            if toolImageItem == nil {
                return self.conn.getDB().eventLoop.makeFailedFuture(Abort(.notFound))
            }
            if toolImageItem!.column("owner")!.int! != context.getUser()!.id {
                print(toolImageItem!.column("owner")!.int!)
                print(context.getUser()!.id)
                return self.conn.getDB().eventLoop.makeFailedFuture(Abort(.unauthorized))
            }
            let uuid = UUID().uuidString
            let s3FileName = uuid + "." + imageType
            let putObjectRequest = S3.PutObjectRequest(acl: .publicRead, body: imageBuffer, bucket: self.s3BucketName, contentEncoding: "base64", contentLength: Int64(imageBuffer.count), key: s3FileName)

            return self.s3.putObject(putObjectRequest)
            .flatMap { response -> EventLoopFuture<PostgresQueryResult> in
                let imageUri = self.s3PublicDomain + s3FileName
                return self.conn.getDB().query("INSERT INTO tool_images (tool, image_uri) VALUES ($1, $2)", [
                    PostgresData(int: toolId),
                    PostgresData(string: imageUri)
                ])
            }
        }
    }

    // Commented out code in case we need to roll back to binary image data

    // func uploadImage(_ data: uploadImageHTTPBody, context: Context) throws -> EventLoopFuture<PostgresQueryResult> {
    //     let toolId = data.toolId
    //     let imageFile = data.imageFile
    //     let imageType = self.imageTypeDecoder(imageFile: imageFile)
        
    //     if imageType == "" {
    //         return self.conn.getDB().eventLoop.makeFailedFuture(Abort(.badRequest))
    //     }
    //     print("here1")
    //     return conn.getDB().query("SELECT * FROM tools WHERE tool_id = $1", [PostgresData(int: toolId)])
    //     .flatMap{ result in
    //         print("here2")
    //         let toolImageItem = result.first
    //         if toolImageItem == nil {
    //             return self.conn.getDB().eventLoop.makeFailedFuture(Abort(.notFound))
    //         }
    //         if toolImageItem!.column("owner")!.int! != context.getUser()!.id {
    //             print(toolImageItem!.column("owner")!.int!)
    //             print(context.getUser()!.id)
    //             return self.conn.getDB().eventLoop.makeFailedFuture(Abort(.unauthorized))
    //         }
    //         let uuid = UUID().uuidString
    //         let s3FileName = uuid + "." + imageType
    //         let putObjectRequest = S3.PutObjectRequest(acl: .publicRead, body: imageFile, bucket: self.s3BucketName, contentLength: Int64(imageFile.count), key: s3FileName)

    //         return self.s3.putObject(putObjectRequest)
    //         .flatMap { response -> EventLoopFuture<PostgresQueryResult> in
    //             print("here3")
    //             let imageUri = self.s3PublicDomain + s3FileName
    //             return self.conn.getDB().query("INSERT INTO tool_images (tool, image_uri) VALUES ($1, $2)", [
    //                 PostgresData(int: toolId),
    //                 PostgresData(string: imageUri)
    //             ])
    //         }
    //     }
    // }

    // private func imageTypeDecoder(imageFile : Data) -> String {
    //     var res : String
    //     res = ""
    //     switch (imageFile[0]) {
    //         case 0xFF:
    //             res = "jpg"
    //         case 0x89:
    //             res = "png"
    //         case 0x52 where imageFile.count >= 12:
    //             let subdata = imageFile[0...11]
    //             if let dataString = String(data: subdata, encoding: .ascii),
    //                 dataString.hasPrefix("RIFF"),
    //                 dataString.hasSuffix("WEBP")
    //             {    
    //                 return "webp"
    //             }
    //         case 0x00 where imageFile.count >= 12 :
    //             let subdata = imageFile[8...11]
    //             let dataString = String(data: subdata, encoding: .ascii)
    //             if Set(["heic", "heix", "hevc", "hevx, mif1"]).contains(dataString)
    //             {    
    //                 return "heic"
    //             }
    //         default:
    //             res = ""
    //     }

    //     return res
    // }
}