const { readFileSync } = require("node:fs");
const { ImportsBuilder } = require("./pat.js");

const wasm = readFileSync("./pat.wasm");

const bldr = new ImportsBuilder();

const pmi = WebAssembly.instantiate(wasm, bldr.funcs4wasm());

const pi = pmi.then(mi => mi.instance);

const pe = pi.then(i => i.exports);

const pmain = pe.then(e => {
  bldr.setMemory(e.memory);

  const main = e.io_main;

  main();
});

pmain.catch(console.error);
