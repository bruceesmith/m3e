/*
	package metrics is responsible for collecting and reporting memory and garbage collector

information as the program progresses
*/
package metrics

import (
	"fmt"
	"runtime"

	"github.com/bruceesmith/logger"
)

const (
	EstimatedEnumerations = 100
	MaxEnumTypeDefs       = 5
)

type sample struct {
	stats  runtime.MemStats
	allocs uint64
	frees  uint64
	numGC  uint32
}

type Metrics struct {
	disabled bool
	samples  map[string]sample
}

func New() *Metrics {
	return &Metrics{samples: make(map[string]sample)}
}

func (m *Metrics) Disable() {
	m.disabled = true
}

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

func (m *Metrics) Report() {
	if m.disabled {
		return
	}
	for id, samp := range m.samples {
		logger.Info("metrics", "id", id, "mallocs", samp.allocs, "frees", samp.frees, "numGC", samp.numGC)
	}
}

func (m *Metrics) Start(id string) {
	if m.disabled {
		return
	}

	var stats runtime.MemStats
	runtime.ReadMemStats(&stats)
	m.samples[id] = sample{stats: stats, allocs: stats.Mallocs, frees: stats.Frees, numGC: stats.NumGC}
}
