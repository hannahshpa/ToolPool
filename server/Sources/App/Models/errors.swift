enum RequestError: Error {
    case missingAuthToken
    case invalidAuthToken
    case invalidRequest
}

enum AuthenticationError: Error {
    case keyFileNotFound
    case invalidToken
    case authenticatorInternalError
}