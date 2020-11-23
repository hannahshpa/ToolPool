import Vapor
import S3

final class S3Uploader {
    private let s3BucketName: String
    private let s3: S3
    init() {
        self.s3BucketName = "toolpool-dev"
        let region = "us-west-1"
        self.s3 = S3(region: .uswest1)
    }

    func uploadImage() -> EventLoopFuture<S3.GetObjectOutput> {
        let s3UploadRequest = S3.CreateBucketRequest(bucket: self.s3BucketName)
        let bodyData = "hello world".data(using: .utf8)!
        let putObjectRequest = S3.PutObjectRequest(acl: .publicRead, body: bodyData, bucket: self.s3BucketName, contentLength: Int64(bodyData.count), key: "hello.txt")

        return self.s3.putObject(putObjectRequest)
        .flatMap { resopnse -> EventLoopFuture<S3.GetObjectOutput> in
            let getObjectRequest = S3.GetObjectRequest(bucket: self.s3BucketName, key: "hello.txt")
            return self.s3.getObject(getObjectRequest)
        }
    }
}