function ImportsBuilder(){
  this.memory = null;

  const decoder = new TextDecoder();

  this.setMemory = (mem) => this.memory = mem;

  this.pat2regexp = (patptr, patlen, flagptr, flaglen) => {
    if(null === this.memory) return null;

    const pview = new DataView(this.memory.buffer, patptr,  patlen);
    const fview = new DataView(this.memory.buffer, flagptr, flaglen);

    const pattern = decoder.decode(pview);
    const flags   = decoder.decode(fview);

    return new RegExp(pattern, flags);
  };

  this.test = (regexp, sptr, slen) => {
    if(null === this.memory) return false;
    if(null === regexp) return false;

    const sview = new DataView(this.memory.buffer, sptr, slen);
    const s = decoder.decode(sview);

    return regexp.test(s);
  };

  this.funcs4wasm = () => {
    return Object.freeze({
      js: Object.freeze({
        pat2regexp: this.pat2regexp,
        test: this.test,

        result2console: (integer) => console.log(integer),
      }),
    });
  };
}

module.exports = { ImportsBuilder };
