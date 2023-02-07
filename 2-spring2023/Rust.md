# Rust

*Author: Darua Shutina*



[TOC]



## 23-02-07

### Crate

A crate is a compilation unit in Rust. Whenever `rustc some_file.rs` is called, `some_file.rs` is treated as the *crate file*.

A crate can be compiled into a binary or into a library. By default, `rustc` will produce a binary from a crate. This behavior can be overridden by passing the flag `--crate-type=lib`.





### Cargo

Cargo is **Rust's build system and package manager**. With this tool, you'll get a repeatable build because it allows Rust packages to declare their dependencies in the file `Cargo.toml`.

Это инструмент, который позволяет билдить, запускать, тестить и фиксить проект.



#### Cargo.toml

В этом файле объявляются имя, версия, сурс и -- главное -- зависимости. В начале файла также добавляется версия проекта (?). 

```rust
version = 3
[[package]]
name = "time"
version = "0.1.45"
source = "registry+https://github.com/rust-lang/crates.io-index"
chacksum = "..."
dependencies = [
  "libc",
  "wasi"
]
```





### Переменные

```rust
let par1: String = "aboba";  // cannot be modified
let mut par2: String = "abober"; // can be modified
let par3 = par1;
```



### Функции

```rust
fn f(par1: String) -> String {
    return format!{"{}{}", par1};
}
fn f(par1: String) {   // <=> void function
    return format!{"{}{}", par1};
}

fn f(mut par1: String) {   
// mut -- переменную можно изменять внутри функции
    return format!{"{}{}", par1};
}
```



### Смысл точки с запятой

Если в конце строки стоит `;`, то строка превращается в statement и ничего не возвращает. Если в такой строке дописать в начале `return`, то тогда она будет что-то возвращать.

Если оставить строку без точки с запятой и без слова `return`, то строка будет что-то возвращать (например, `void`).

```rust
fn f(par1: String) -> String {
    return format!("{}{}", par1);
}

fn f(par1: String) -> String {
    format!("{}{}", par1)
}
```



### Макросы 

#### format!

```rust
format!("{}", variable);

marco_rules! format {
    ($($arg:tt)*) => {{
        let res =
    $crate::fmt::format($crate""__export::format_args!($($atg)*));
        res
    }}
}
```



#### panic!

Аналог выкидывания исключений. Мы можем кидать панику и перехватывать панику, вот класс!

```rust
panic!("It's over");
```



### Data types

- Numeric -- всевозможные числа и операции над ними 

  Возможные типы: 

  - `i8` (int 8 bit), `u8` (unsigned int 8 bit), ..., `i128`, `u128`; 
  - `f32`, `f64`, `0xff`;
  - etc. 

  Если происходит переполнение, то получим `panic!` в режиме дебага и `overflow` в обычном режиме. 

- bool

- char 32bit: `'a'`

  Строка в расте -- это не массив чаров, а какая-то более сложная вещь

- array

- tuple

- etc



### If

Фигурные скобочки обязательные

```rust
if a > 0 {
    // do smth
} else {
    // do smth
}

let b: i32 = if a > 0 { 1 } else { 2 };
```



### Loop

```rust
loop {
    counter += 1;
    if counter > 42 {
        break
    }
}



let b = loop {
    counter += 1;
    if counter > 42 {
        break counter * 2
    }
};
// `loop` вернет 84, и это значение положится в `b`
// после второй `}` ставится точка с запятой, потому что присваивание -- это всегда statement и требует точку с запятой. 



let b = 'main_loop: loop {
    loop {
        counter += 1;
        if counter > 42 {
            break 'main_loop counter * 2
        }
    }
};
// используем лейбл для цикла 
```



### While/for

```rust
let mut counter = 0;

while counter < 42 {
    counter += 1;
}

for _ in 0..42 {
    println!("we are in a while loop");
}
```

`while` -- это `loop` с условием. Но, в отличие от `loop`, он не может возвращать значение (`loop` может, пример выше). 







