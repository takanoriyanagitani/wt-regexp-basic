(module

  (import "js" "pat2regexp"
    (func $pat2regexp (param i32 i32 i32 i32) (result externref)))

  (import "js" "test"
    (func $test (param externref i32 i32) (result i32)))

  (import "js" "result2console" (func $result2console (param i32)))

  (memory (export "memory") 3)

  (data (i32.const 0x0001_0000) "^HELO")
  (data (i32.const 0x0001_1000) "i")

  (data (i32.const 0x0002_0000) "helo")
  (data (i32.const 0x0002_1000) "HeLo")
  (data (i32.const 0x0002_2000) "He1o")

  (func $io_main (export "io_main")
    (local $regexp externref)

    (local $patptr i32)   (local $patlen i32)
    (local $flagsptr i32) (local $flagslen i32)

    (local $hs0ptr i32) (local $hs0len i32)
    (local $hs1ptr i32) (local $hs1len i32)
    (local $hs2ptr i32) (local $hs2len i32)

    (local $test0 i32)
    (local $test1 i32)
    (local $test2 i32)

    i32.const 0x0001_0000 local.set $patptr
    i32.const 4           local.set $patlen

    i32.const 0x0001_1000 local.set $flagsptr
    i32.const 1           local.set $flagslen

    local.get $patptr   local.get $patlen
    local.get $flagsptr local.get $flagslen
    call $pat2regexp local.set $regexp

    i32.const 0x0002_0000 local.set $hs0ptr i32.const 4 local.set $hs0len
    i32.const 0x0002_1000 local.set $hs1ptr i32.const 4 local.set $hs1len
    i32.const 0x0002_2000 local.set $hs2ptr i32.const 4 local.set $hs2len

    local.get $regexp local.get $hs0ptr local.get $hs0len
    call $test local.set $test0

    local.get $regexp local.get $hs0ptr local.get $hs0len
    call $test local.set $test0

    local.get $regexp local.get $hs1ptr local.get $hs1len
    call $test local.set $test1

    local.get $regexp local.get $hs2ptr local.get $hs2len
    call $test local.set $test2

    local.get $test0 call $result2console
    local.get $test1 call $result2console
    local.get $test2 call $result2console
  )

)
