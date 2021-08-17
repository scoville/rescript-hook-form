@unboxed
type rec t = Any('a): t

let sync = syncHandler => Any(syncHandler)

let async = asyncHandler => Any(asyncHandler)
