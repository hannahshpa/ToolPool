enum RequestError: Error {
    case missingAuthToken
    case invalidRequest
}

enum AuthenticationError: Error {
    case keyFileNotFound
    case invalidToken
    case authenticatorInternalError
    case unauthorized
}

enum ImageUploadError: Error {
    case invalidImageFileType
}