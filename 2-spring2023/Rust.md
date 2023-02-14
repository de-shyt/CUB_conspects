# Rust

*Author: Darua Shutina*



[TOC]



## 23-02-07

rustlings <img src="https://github.githubassets.com/images/icons/emoji/unicode/1f980.png" alt="crab" style="zoom:43%;" ><img src="https://github.githubassets.com/images/icons/emoji/unicode/2764.png" alt="heart" style="zoom:35%;" /> : https://github.com/rust-lang/rustlings



### Crate

A crate is a compilation unit in Rust. Whenever `rustc some_file.rs` is called, `some_file.rs` is treated as the *crate file*.

A crate can be compiled into a binary or into a library. By default, `rustc` will produce a binary from a crate. This behavior can be overridden by passing the flag `--crate-type=lib`.





### Cargo

Cargo is **Rust's build system and package manager**. With this tool, you'll get a repeatable build because it allows Rust packages to declare their dependencies in the file `Cargo.toml`.

Это инструмент, который позволяет билдить, запускать, тестить и фиксить проект.

Создать новый проект:

```sh
$ cargo new new_project  
$cd new_project  

$cargo init
```





#### Cargo.toml

В этом файле объявляются имя, версия, сурс, чексумм и зависимости. В начале файла также добавляется версия проекта (?). 

```rust
version = 3
[[package]]
name = "time"
version = "0.1.45"
source =
"registry+https://github.com/rust-lang/crates.ioindex"
checksum =
"1b797afad3f312d1c66a56d11d0316f916356d11158fbc6ca6389ff6bf805a"
dependencies = [
"libc",
"wasi",
"winapi 0.3.9",
]
```

`сhecksum` - это хеш для цифровой подписи. Когда заливаешь свой пакет в репозиторий, от него формируется Криптографический Хеш и прописывается локально.

Если злоумышленник получит доступ к пакетному менеджеру и попробует подменить пакет, то не пройдет билд, так как сохраненный хеш и хеш пакета не совпадут.





### Переменные

```rust
let par1: String = "aboba";  // cannot be modified
let mut par2: String = "abober"; // can be modified
let par3 = par1;
```





### Функции

```rust
fn f(par1: String) -> String {
    return format!{"{}", par1};
}
fn f(par1: String) {   // <=> void function
    println!{"{}", par1};
}

fn f(mut par1: String) {   
// mut => переменную можно изменять внутри функции
    println!{"{}", par1};
}
```





### Смысл точки с запятой

Если в конце строки стоит `;`, то строка превращается в statement и ничего не возвращает. Если в такой строке дописать в начале `return`, то тогда она будет что-то возвращать.

Если оставить строку без точки с запятой и без слова `return`, то строка будет что-то возвращать:

```rust
fn f(par1: String) -> String {
    return format!("{}", par1);
}

fn f(par1: String) -> String {
    format!("{}", par1)
}
```





### Макросы 

#### `format!`

Возвращает отформатированный текст в виде строки. 

```rust
format!("the value is {var}", var = "aboba");
```



#### `print!` и `println!`

То же, что и `format!`, но печататают вывод в `io::stdout`.



#### `eprint!` и `eprintln!`

То же, что и `format!`, но печататают вывод в `io::stderr`.



#### `panic!`

Аналог выкидывания исключений. Мы можем кидать панику и перехватывать панику, вот класс!

```rust
panic!("this is my message");
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









## 23-02-14

### Structs

```rust
struct MyStruct {
    val1: i32,
    val2: bool,
}

let struct = MyStruct {
    val1: 42,
    val2: true,
}
```



```rust
struct MyStructRef {
    ref: &i32,  // ссылочная переменная
}

let var1 = MyStructRef {
    ref: &42  // ссылка на значение `42`
}
let var2 = var1
```

<img src="./pics for conspects/RUST/RUST 23-02-14 1.png" alt="RUST 23-02-14 1" style="zoom:69%;" />





### String: общие черты

```rust
pub struct String {
    vec: Vec<u8>,
}
```

`Vec<u8>` -- это не просто вектор чаров. Один чар занимает 32 бита. В строке один символ может занимать две ячейки илз-за кодирования. Если будем обращаться к одной ячейке, не факт, что получим символ, который хотим. 





### Ownership

- [Copy](####Copy) -- копирование
- [Move](####Move) -- перемещение
- [Drop](####Drop) -- удаление данных
- [Borrowing](####Borrowing) -- обращение по ссылке
  - [Dangling refs](####Dangling references)
  - [Mutable refs](####Mutable references)
  - [Mutable vs shared refs](####Mutable vs shared references)
  - [Dereference via `*`](####Dereference via `*`)
  - [Кража или замена?](####Меняем значение по ссылке или крадем значение?)
  - [Dereference via `.`](#####Тут замена)
  - [Copy trait](###Copy trait)
  - [Выводы](###Выводы)





#### Copy

Класическая операция `copy`. В расте не является поведением по умолчанию. 

Для более сложных структур нужно явно указывать, что структура копируется:

```rust
pub trait Copy: Clone {
    // Empty. Need to be implemented.
}
```





#### Move

В расте операция `move` является поведением по умолчанию. 



##### Пример 1: присвоение данных переменной 

```rust
let var1 = myStruct;
let var2 = var1;
println!("{}", var1); // error
```

Происходит перемещение структуры из `var1` в `var2`. Теперь данные в `var1` перестают быть доступными. Если захотим напечатать что-то из `var1`, получим ошибку:

```sh
error[E0382]: borrow of moved value: `var1`:
let var2 = var1;
    ---- value moved here
println!("{}", var1);
               ^^^^ value borowed here after move
```



Чтобы жили обе переменные, можно сделать ссылочную переменную:

```rust
let var1 = myStruct;
let var2 = &var1;
```



##### Пример 2: переменная как аргумент функции

```rust
let var1 = myStruct;
myFunction(var1);
println!("{}", var1);
```

```shell
error[E0382]:
my_fn(var1);
      ---- value moved here
println!("{}", var1);
               ^^^^ value borrowed here after moveborrow of moved value: `var1`
```





#### Drop

`drop` затирает данные в переменной. 

```rust
pub fn drop<T>(_x: T) {}
```



##### Drop on move out of scope

```rust
let var1 = my_struct;
{
   let var2 = var1;
}
```

При выходе из скоупа данные уже не хранятся внутри `var1`. И данные уже стерты из `var2`, потому что мы вышли из скоупа и произошел `drop`. 





#### Borrowing

Это обычное обращение по ссылке. Отличие в том, что для `borrowing` есть `compile-check` проверки, чтобы гарантировать, что ссылка валидная. 

После создания ссылки нельзя организовать перемещение, получим ошибку компилятора:

```rust
let var1 = myStruct;
let var2 = &var1;
my_move(var1);
println!("{}", var2);
```

```shell
error[E0505]: cannot move out of `var` because it is borrowed
my_move(var1);
        ^^^^
```



**Замечание:** если прямо передавать переменную `var` в `println!`?, то переменную больше нельзя использовать. Если передавать ее как `&var`, то переменную можно использовать потом. 





#### Dangling references

##### Пример

```rust
fn createAndReturnRef() -> &String {
    let s = String::from("aboba");
    &s
}
```

Ошибка компиляции. При выходе из функции переменная `s` стирается. Ссылка ведет на ту часть фрейма, которая уже уничтожена:

```shell
error[E0515]: cannot return reference to local variable `s`
&s
^^ returns reference to data owned by the current function
```





#### Mutable references

Вот мы в функцию передаем переменную по ссылке. Внутри функции хотим поменять переменную:

```rust
fn main() {
    let mut var = String::from("Hello");
	append_world(&var);
	println!("{}", var)
}

fn append_world(str: &String){
   str.push_str(" World!")
}
```

Получаем ошибку:

```shell
error[E0596]: cannot borrow `*str` as mutable, as it is behind a `&`
reference
str.push_str(" World!")
`str` is a `&` reference, so the data it refers to cannot be borrowed as
mutable
```

Надо явно прописать, что переданный аргумент -- это мутабельная ссылка:

```rust
fn append_world(str: &mut String){
   str.push_str(" World!")
}
```

Теперь получаем другую ошибку:

```shell
error[E0308]: mismatched types
    append_world(&var);
    ------------ ^^^^ types differ in mutability
	|
	arguments to this function are incorrect
= note: expected mutable reference `&mut String`
        found reference `&String`
```

Проблема в том, что при вызове функции мы передаем немутабельную ссылку. 

Finally, корректный код:

```rust
fn main() {
        let mut var = String::from("Hello");
    append_world(&mut var);  // изменения тут
    println!("{}", var)
}

fn append_world(str: &mut String){
    str.push_str(" World!")
}
```





#### Mutable vs shared references

<img src="./pics for conspects/RUST/RUST 23-02-14 2.png" alt="RUST 23-02-14 2" style="zoom:50%;" />

Нельзя создать mutable ссылку, если есть хотя бы одна shared ссылка, и наоборот. 





#### Dereference via `*`

```rust
let x = 5;
let y = &x;

assert_eq!(5, x);  // true
assert_eq!(5, *y); // true. переходим по ссылке `y`
assert_eq!(5, y);  // false. `y` -- это ссылка на `5`
```

<img src="./pics for conspects/RUST/RUST 23-02-14 3.png" alt="RUST 23-02-14 3" style="zoom:99%;" />





#### Меняем значение по ссылке или крадем значение?

##### Тут кража

```rust
let mut var = String::from("aboba");
let reference = &mut var;
let moved = *reference;
```

Пытаемся из `var` переместить значение в `moved`. Это кража! Так в расте делать нельзя:

```shell
error[E0507]: cannot move out of `*reference` which is behind a mutable reference

let moved = *reference;
            ^^^^^^^^^^
            |
            move occurs because `*reference` has type `String`, which does not implement the `Copy` trait
```



##### Тут замена

```rust
let mut var = String::from("aboba");
let reference = &mut var;
*reference = String::from("abober");
```

Поменяли значение в переменной `var`. Так в расте делать можно.





#### Dereference via `.`

```rust
let mut var = String::from("aboba");
let ref = &mut var;

(*ref).push_str("aboba");
ref.push_str("aboba");
```

Если есть ссылка на ссылку на ссылку на переменную, то, поставив одну точку, мы пройдем по всему этому пути сразу к значению переменной. Во прикол. 





### Copy trait

- обычное копирование
- не overloadable
- всё что `Copy`, является еще и `Clone`. Но не наоборот
- Нельзя реализовать `Copy` для `&mut` переменных (потому что `&mut` -- это уникальная ссылка)
- Не стоит реализовывать `Copy` для мутабельных структур





### Выводы \todo

> В плюсах очень легко выстрелить себе в ногу, и её там оторвёт нахрен. 
>
> Чтобы выстрелить в ногу в расте, надо очень хорошо прицелиться.





