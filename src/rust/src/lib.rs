use extendr_api::prelude::*;
/// dirtylapply replicates R's lapply: it takes an R list and an R function,
/// applies the function to each element, and returns a new list of results.
#[extendr]
fn rustylapply(list: List, func: Robj, varargs: List) -> List {
    let fun = cast_robj_to_function(func);

    let results: Vec<Robj> = list
        .iter()
        .map(|(_name, value)| {
            let args = collect_r_fn_args(value, &varargs);
            call_r_fn(&fun, args)
        })
        .collect();

    List::from_values(results)
}

fn call_r_fn(fun: &Function, args: Pairlist) -> Robj {
    match fun.call(args) {
        Ok(result) => result,
        Err(err) => panic!("Error: {:?}", err),
    }
}

fn collect_r_fn_args(value: Robj, varargs: &List) -> Pairlist {
    let mut pairs: Vec<(String, Robj)> = Vec::new();
    pairs.push(("x".to_string(), value.clone()));
    for (name, arg) in varargs.iter() {
        pairs.push((name.to_string(), arg.clone()));
    }
    Pairlist::from_pairs(pairs)
}

fn cast_robj_to_function(func: Robj) -> Function {
    func.as_function()
        .expect("Provided object is not a function.")
}
// Macro to generate exports.
// This ensures exported functions are registered with R.
// See corresponding C code in `entrypoint.c`.
extendr_module! {
    mod dirtyparallel;
    fn rustylapply;
}
