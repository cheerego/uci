package ptr

func Ptr[T any](v T) *T {
	return &v
}

func Ptrs[T any](v []T) []*T {
	ptrs := make([]*T, len(v))
	for i := 0; i < len(v); i++ {
		ptrs[i] = &v[i]
	}
	return ptrs
}
