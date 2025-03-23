use extendr_api::prelude::*;
/// dirtylapply replicates R's lapply: it takes an R list and an R function,
/// applies the function to each element, and returns a new list of results.
#[extendr]
fn rustylapply(list: List, func: Robj, varargs: List) -> List {
    let fun = func
        .as_function()
        .expect("Provided object is not a function.");

    let results: Vec<Robj> = list
        .iter()
        .map(|(_name, value)| {
            let mut pairs: Vec<(String, Robj)> = Vec::new();
            pairs.push(("value".to_string(), value.clone()));
            for (name, arg) in varargs.iter() {
                pairs.push((name.to_string(), arg.clone()));
            }
            let args = Pairlist::from_pairs(pairs);
            match fun.call(args) {
                Ok(result) => result,
                Err(err) => Robj::from(format!("Error: {:?}", err)),
            }
        })
        .collect();

    List::from_values(results)
}

// Accepts a list of arbitrary R objects
#[extendr]
fn call_rust_with_varargs(args: List) -> Strings {
    let strs: Vec<String> = args.values().map(|val| format!("{:?}", val)).collect();

    Strings::from_values(strs)
}
// Macro to generate exports.
// This ensures exported functions are registered with R.
// See corresponding C code in `entrypoint.c`.
extendr_module! {
    mod dirtyparallel;
    fn rustylapply;
    fn call_rust_with_varargs;
}
