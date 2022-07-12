package syncmap

import "sync"

type Map[T any] struct {
	m *sync.Map
}

func New[T any]() *Map[T] {
	return &Map[T]{&sync.Map{}}
}

func (s *Map[T]) Load(key any) (T, bool) {
	var t T

	load, ok := s.m.Load(key)
	if ok {
		return load.(T), true
	}
	return t, false
}

func (s *Map[T]) Store(key any, val T) {
	s.m.Store(key, val)
}

func (s *Map[T]) Delete(key any) {
	s.m.Delete(key)
}

func (s *Map[T]) LoadAndDelete(key any) (T, bool) {
	var t T
	val, ok := s.m.LoadAndDelete(key)
	if ok {
		return val.(T), true
	}
	return t, false
}

func (s *Map[T]) LoadOrStore(key any, value T) (T, bool) {
	var t T
	val, ok := s.m.LoadOrStore(key, value)
	if ok {
		return val.(T), true
	}
	return t, false
}

func (s *Map[T]) Range(f func(key, value any) bool) {
	s.m.Range(f)
}
