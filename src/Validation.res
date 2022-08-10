@unboxed
type rec t = Any('a): t

let sync = syncHandler => Any(syncHandler)

let syncWithCustomError = syncHandler => Any(syncHandler)

let async = asyncHandler => Any(asyncHandler)

let asyncWithCustomError = asyncHandler => Any(asyncHandler)
