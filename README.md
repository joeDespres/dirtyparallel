# Dirty Parallel R-Rust Implementation

This project is an experiment aimed at pushing the limits of multicore processing in R by integrating Rust’s high-performance, multi-threaded capabilities. The idea is to bypass some of R’s inherent single-threaded constraints by using unsafe Rust code—what we call the "dirty parallel" approach—to achieve significant speedups.

## Drop in lapply
- [x] build a rust implementation of `lapply()`
  - [x] take varargs
  - [x] assert all args are named
  - [x] demand all args passed in by name
  - [x] permit arbitrary argument names
  
## Core Functionality
- [ ] implement a dirty parallel version of `parallel::mclapply`
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
- [ ] ?Add exponential backoff or a cooldown delay between retries

## Function Validation (R side)

- [ ] Create a `safe_for_parallel()` validator fail early if a function is deemed unsafe
  - [ ] Must not use shared memory
  - [ ] Must not use unsafe globals (e.g., `<<-`, `assign`)
  - [ ] Must not call known side-effect functions
- [ ] Use {lintr} to statically inspect functions

## Benchmarking

- [ ] Benchmark `raw_dirty_lapply()` vs. `mclapply()`
- [ ] Stress test with simulated GC and side-effect functions
