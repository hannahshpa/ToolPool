import Vapor
import PostgresKit
import NIO
import S3

final class ImageController {
    private let s3: S3
    private let s3BucketName: String
    private let awsRegion: String
    private let s3PublicDomain :String
    public static var instance = ImageController()

    private init() {
        self.s3BucketName = ProcessInfo.processInfo.environment["ENV"] == "production" ? "toolpool-prod" : "toolpool-dev"
        self.awsRegion = "us-west-1"
        self.s3 = S3(region: Region(rawValue: awsRegion))
        self.s3PublicDomain = "https://" + self.s3BucketName +  ".s3-" + self.awsRegion + ".amazonaws.com/"
    }

    func uploadImage(_ data: uploadImageHTTPBody, context: Context) throws -> EventLoopFuture<PostgresQueryResult> {
        let toolId = data.toolId
        let imageFile = data.imageFile
        let imageType = self.imageTypeDecoder(imageFile: imageFile)
        guard let user = context.user else{
            return context.eventLoop.makeFailedFuture(Abort(.forbidden))
        }
        if imageType == "" {
            return context.eventLoop.makeFailedFuture(Abort(.badRequest))
        }

        return context.db.query("SELECT * FROM tools WHERE tool_id = $1", [PostgresData(int: toolId)])
        .flatMap{ result in
            let toolImageItem = result.first
            if toolImageItem == nil {
                return context.eventLoop.makeFailedFuture(Abort(.notFound))
            }
            if toolImageItem!.column("owner")!.int! != user.id {
                print(toolImageItem!.column("owner")!.int!)
                print(context.user!.id)
                return context.eventLoop.makeFailedFuture(Abort(.unauthorized))
            }
            let uuid = UUID().uuidString
            let s3FileName = uuid + "." + imageType
            let putObjectRequest = S3.PutObjectRequest(acl: .publicRead, body: imageFile, bucket: self.s3BucketName, contentLength: Int64(imageFile.count), key: s3FileName)

            return self.s3.putObject(putObjectRequest)
            .flatMap { response -> EventLoopFuture<PostgresQueryResult> in
                let imageUri = self.s3PublicDomain + s3FileName
                return context.db.query("INSERT INTO tool_images (tool, image_uri) VALUES ($1, $2)", [
                    PostgresData(int: toolId),
                    PostgresData(string: imageUri)
                ])
            }
        }
    }

    private func imageTypeDecoder(imageFile : Data) -> String {
        var res : String
        res = ""
        switch (imageFile[0]) {
            case 0xFF:
                res = "jpg"
            case 0x89:
                res = "png"
            case 0x52 where imageFile.count >= 12:
                let subdata = imageFile[0...11]
                if let dataString = String(data: subdata, encoding: .ascii),
                    dataString.hasPrefix("RIFF"),
                    dataString.hasSuffix("WEBP")
                {    
                    return "webp"
                }
            case 0x00 where imageFile.count >= 12 :
                let subdata = imageFile[8...11]
                let dataString = String(data: subdata, encoding: .ascii)
                if Set(["heic", "heix", "hevc", "hevx, mif1"]).contains(dataString)
                {    
                    return "heic"
                }
            default:
                res = ""
        }

        return res
    }
}
