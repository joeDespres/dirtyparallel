# Dirty Parallel R-Rust Implementation

This project is an experiment to push the limits of multicore processing in R by integrating Rust’s high-performance, multi-threaded capabilities. The idea is to bypass some of R’s inherent single-threaded constraints by using unsafe Rust code the "dirty parallel" approach.

## Core Functionality

- [x] Rust implementation of `lapply()`
- [ ] handle varargs `...`
- [ ] Implement a dirty parallel version of `lapply()`
- [ ] Use shared memory access
- [ ] ?Disable R's garbage collector during execution

## Safety and Guardrails

- [ ] memory watchdog using sysinfo
- [ ] Abort threads on memory threshold
- [ ] ?Expose memory threshold and interval as parameters from R
- [ ] ?Ensure threads stop cleanly after an abort signal

## Retry Logic

- [ ] ?Add a retry loop for failed threads
- [ ] Return partial results with a retry status (e.g., "RETRY FAILED")
- [ ] Add exponential backoff or a cooldown delay between retries

## Function Validation (R side)

- [ ] Create a `safe_for_parallel()` validator fail early if a function is deemed unsafe
  - [ ] Must not use shared memory
  - [ ] Must not use unsafe globals (e.g., `<<-`, `assign`)
  - [ ] Must not call known side-effect functions
- [ ] Use {lintr} to statically inspect functions

## Benchmarking

- [ ] Benchmark `raw_dirty_lapply()` vs. `mclapply()`
- [ ] Stress test with simulated GC and side-effect functions
