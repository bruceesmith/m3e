package metrics

import (
	"fmt"
	"runtime"

	"github.com/bruceesmith/logger"
)

// sample is a set of memry & GC metrics. It stores the difference between
// the runtime metrics when it was created by ST=tart() and when it was
// closed by End()
type sample struct {
	stats  runtime.MemStats
	allocs uint64
	frees  uint64
	numGC  uint32
}

// Metrics is a container for zero or more sets of runtime metric samples
type Metrics struct {
	disabled bool
	samples  map[string]sample
}

// New creates a new container for runtime metric samples
func New() *Metrics {
	return &Metrics{samples: make(map[string]sample)}
}

// Disable stops collection of metrics, turning the various methods (Start, End
// and Report) into no-ops. This allows calls to these functions to be left in
// code but not actually do anything
func (m *Metrics) Disable() {
	m.disabled = true
}

// End captures the current runtime metrics and calculates the difference between
// them and the set of runtime metrics captured when Start() was called
func (m *Metrics) End(id string) (err error) {
	if m.disabled {
		return nil
	}
	samp, ok := m.samples[id]
	if !ok {
		return fmt.Errorf("cannot close sample %s, it does not exist", id)
	}
	var stats runtime.MemStats
	runtime.ReadMemStats(&stats)
	samp.allocs = stats.Mallocs - samp.allocs
	samp.frees = stats.Frees - samp.frees
	samp.numGC = stats.NumGC - samp.numGC
	m.samples[id] = samp
	return nil
}

// Report creates a report of each of the samples that have been captured to date
func (m *Metrics) Report() {
	if m.disabled {
		return
	}
	for id, samp := range m.samples {
		logger.Info("metrics", "id", id, "mallocs", samp.allocs, "frees", samp.frees, "numGC", samp.numGC)
	}
}

// Start captures the runtime metrics and initialises a new sample from them
func (m *Metrics) Start(id string) {
	if m.disabled {
		return
	}

	var stats runtime.MemStats
	runtime.ReadMemStats(&stats)
	m.samples[id] = sample{stats: stats, allocs: stats.Mallocs, frees: stats.Frees, numGC: stats.NumGC}
}
