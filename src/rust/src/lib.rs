use extendr_api::prelude::*;
/// dirtylapply replicates R's lapply: it takes an R list and an R function,
/// applies the function to each element, and returns a new list of results.
#[extendr]
fn dirtylapply(list: List, func: Robj) -> List {
    let fun = func
        .as_function()
        .expect("Provided object is not a function.");

    let results: Vec<Robj> = list
        .iter()
        .map(|(_name, value)| {
            let args = pairlist!(value = value.clone());
            match fun.call(args) {
                Ok(result) => result,
                Err(err) => {
                    // Return an informative error message instead of panicking.
                    Robj::from(format!("Error: {:?}", err))
                }
            }
        })
        .collect();

    List::from_values(results)
}

// Macro to generate exports.
// This ensures exported functions are registered with R.
// See corresponding C code in `entrypoint.c`.
extendr_module! {
    mod dirtyparallel;
    fn dirtylapply;
}
