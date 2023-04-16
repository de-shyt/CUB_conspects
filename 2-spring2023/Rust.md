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

`Vec<u8>` -- это не просто вектор чаров. Один чар занимает 32 бита. В строке один символ может занимать две ячейки из-за кодирования. Если будем обращаться к одной ячейке, не факт, что получим символ, который хотим. 





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

##### Пример 1: возвращение из функции

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





##### Пример 2: разные лайфтаймы

```rust
let mut s_ptr: &String;
{
    let s = String::from("aboba");
    s_ptr = &s
}
println!("{}", *s_ptr)
```

Ошибка компиляции. Обращаемся к данным, которые жили в другом скоупе и к моменту обращения уже умерли:

```shell
error[E0597]: `s` does not live long enough
s_ptr = &s
        ^^ borrowed value does not live long enough

`s` dropped here while still borrowed
println!("{}", *s_ptr)
               ------ borrow later used here
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









## 23-02-21

### mut переменная или mut значение?

```rust
fn f(mut mutable: &i32, immutable: &i32, mut_ref: &mut i32) {
    mutable = &666;
    println!("{}", *immutable);
    *mut_ref = 666;
}
```

Если переменная `mut`, то в ней можно поменять значение. Например, присвоить ссылку на другой объект. 

Если в перменной хранится ссылка на мутабельный объект (`&mut`), по этой ссылке можно поменять значение объекта. 

Если в переменной хранится ссылка на обычный объект (`&`), то, грубо говоря, данные объекта открыты только для чтения. 

<img src="./pics for conspects/RUST/RUST 23-02-21 1.png" alt="RUST 23-02-21 1" style="zoom:67%;" />







### Указатель vs ссылка

Можно создать raw pointer. Это указатель, который привязывается к определенной области памяти. Раст не проверяет, валиден ли указатель. 

В отличие от указателя, ссылка привязывается к объекту, а не к области памяти. 







### Lifetime specifiers

Есть как минимум два способа получить dangling reference. Чтобы такого не было, можно явно указать, из какого скоупа переменная. Синтаксис: `'x`.

Пример:

```rust
fn main() {
    let str1: String = String::from("aboba");
    let str2: String = String::from("abober");

    println!("longest string = '{}'", find_longest_string(&str1, &str2))
}

fn find_longest_string<'a>(x: &'a String, y: &'a String) -> &'a String {
    if x.len() > y.len() { x } else { y }
}
```

Если убрать лайфтаймы, то код не скомпилится, потому что функция возвращает ссылку на умирающий объект.





#### Lifetime bounds

`b: a` означает, что лайфтайм `b` входит в лайфтайм `a`. Пример:

```rust
fn get_reference_tuple<'a, 'b: 'a>(left: &'a MyStruct, right: &'b MyStruct)
    -> (&'a i32, &'a i32)
{
    (&left.value1, &right.value1)
}
```









## 23-02-28

### Struct Update Syntax

```rust
struct MyBigStruct {
    value1: i32,
    value2: i32,
    value3: i32,
    value4: i32,
    value5: i32,
    value6: i32,
    value7: String,
}

fn main() {
    let var1 = MyBigStruct{
        value1: 1, value2: 2, value3: 3,
        value4: 4, value5: 5, value6: 6,
        value7: String::from("Hello World"),
    };
    let var2 = MyBigStruct{
        value1: 42,
        ..var1 // all elems except `value1` are moved 
               // from `var1` to `var2` 
    };
    
    println!("{}", var1.value1);
    println!("{}", var2.value1);
    println!("{}", var1.value7); // does not compile
}
```

```asciiarmor
error[E0382]: borrow of moved value: `var1.value7`
    println!("{}", var1.value7);
                   ^^^^^^^^^^^ value borrowed here after move
```





 

### Tuples 

#### Синтаксис

```rust
let tuple: (i32, bool, String) = (42, true, String::from("Hi"));
let number = tuple.0;
let (num, bool, str) = tuple; // move for string, copy for others
```





#### Проблема тупла и Borrowing

```rust
struct StrWithTuple {
    field: (i32, bool, String),
}

fn main() {
    let tuple: (i32, bool, String) = (42, true, String::from("Hi"));
    
	let (num, bool, str) = tuple;
    let newStruct = StrWithTuple { field: tuple };
    // does not compile. A string `Hi` was moved into `str`.
}
```

Не скомпилится из-за строки 9. Мы пытаемся создать структуру из `tuple`, но `Hi` была перемещена из `tuple` в переменную `str`.

Корректный код:

```rust
fn main() {
    let tuple: (i32, bool, String) = (42, true, String::from("Hi"));
    
	let (num, bool, ref str) = tuple; // keyword `ref`
    let newStruct = StrWithTuple { field: tuple };
    
    
    println!("{}", str); // does not compile.
    // Data was moved into `newStruct.field`,
    // and reference stored in `str` is not valid anymore. 
}
```







### TupleStruct

Как обычная структура, но поля без имен. Имеет смысл использовать, если поля разных типов (тогда можно догадаться, какое поле что означает).

```rust
struct TupleStruct(i32, i32);
let point = TupleStruct(42, 666);
```







### Unit

По конструкции, `Unit` -- это пустой тупл. Штука, которая не хранит никаких данных. 

```rust
let unit = ();
```

Если не нужно создавать структуру для хранения данных (i.e. данных нет), можно использовать `Unit`, который занимает 0 байтов памяти. 





#### StructUnit

Частный случай `Unit`. Пустая структура, на которую можно потом навесить метаданные с помощью аттрибутов. 

```rust
struct UnitStruct;

let unit_struct = UnitStruct;

let unit: () = while false {};
// в расте все возвращает значение, просто иногда это `Unit`. 
// например, цикл `while`.
```







### Bang (!)

Тип `Bang`. Оозначается как `!`.  Означает, что текущий код никогда не будет достижим. Пример -- бесконечный `loop`, который как раз вернет `!`:

```rust
let bang_loop: ! = loop {};
let bang_panic: ! = panic!();

let bang_unimpl: ! = unimplemented!();
// макрос; используется, если еще нет реализации для метода. 
```







### Реализация методов у структур

Методы реализуются в блоке с ключевым словом `impl <struct_name>`. В качестве аргумента передается ссылка на сам объект --  `&self`:

```rust
struct MyStruct {
    val1: i32,
}

impl MyStruct {
    fn print_me(&self) {
        println!("val1 = {}", self.val1);
    }
}

fn main() {
    let aboba = MyStruct {
        val1: 42,
    };
    
    MyStruct::print_me(&aboba);
    aboba.print_me();
}
```

`impl` блоков может быть несколько, но методы не должны повторяться. `impl` блок должен быть в том же кейте, что и определение структуры. 





#### Associated functions

Ассоциированная функция -- любая функция в блоке `impl`. Её можно вызвать только через синтаксис `<struct_name>::`. 

Метод -- это ассоциированная функция, в которую в качестве аргумента передается `&self`. Метод можно вызвать любым способом. 





#### new

Общая договоренность, что так называется конструктор. 

```rust
impl MyStruct {
    fn new(value1: i32, value2: bool) -> Self {
        Self { value1, value2 }
    }

    // если на объект кто-то в коде уже ссылается,
    // метод вызвать не удастся. 
    fn update_me(&mut self, new_value1: i32) {
        self.value1 = new_value1;
    }

    fn move_me(self, new_owner: &mut (i32, MyStruct)) {
        new_owner.1 = self;
    }
    
    // деструктор. Параметр передается без ссылки (с помощью move), поэтому,
    // когда выходим из тела функции, переданный параметр умирает, память чистится.
    fn kill(self) {}
}
```





```rust
impl MyStruct {
    fn any_static_method() {}

    fn new(value1: i32, value2: bool) -> Self {
        Self { value1, value2 }
    }

    fn print_me(&self) {
        println!("{}{}", self.value1, self.value2);
    }

    fn update_me(&mut self, new_value1: i32) {
        self.value1 = new_value1;
    }

    fn move_me(self, new_owner: &mut (i32, MyStruct)) {
        new_owner.1 = self;
    }

    fn kill(self) {}
}

```







### Traits

Что-то похожее на интерфейсы, но с возможностью дефолтной реализации. Трейты используются для:

- дефолтной реализации методов,
- статического полиморфизма,
- динамического полиморфизма.

Блок `trait` -- это объявление того, что способен сделать объект. 

Блок `impl` -- реализация объявленных методов для какой-то определенной структуры. 

```rust
trait MyTrait {
    fn print_me(&self);
    // здесь же может быть дефолтная реализация 
}

// реализация для структуры
impl MyTrait for MyStruct {
    fn print_me(&self) {
        println!("{}{}", self.value1, self.value2);
    }
}

// реализация для ссылки на структуру
impl MyTrait for &MyStruct {
    fn do (self) {
        let it_is_reference: &MyStruct = self;
    }
}
```

Реализацию для ссылки на структуру необходимо вызывать явно, через `::`. Иначе будет вызываться реализация для структуры (по дефолту).  





#### Пример использования `trait`

```rust
struct MyStruct { val1: i32, }

trait MyTrait {
    fn print_me(&self) { 
        println!("{}", self.get_val1());
    }
    fn get_val1(&self) -> i32;
}

impl MyTrait for MyStruct {
    fn get_val1(&self) -> i32 { self.val1 }
}

fn main() {
    let my_struct = MyStruct { val1: 42, };
    my_struct.print_me();
}
```





#### Трейты для (простых) типов

```rust
impl MyTrait for i32 {
    fn get_value1(&self) -> String {
        self.to_string()
    }

    fn get_value2(&self) -> String {
        self.to_string()
    }
}

let str: String = 42.get_value1();
```





#### Default

```rust
#[derive(Default)]
struct MyLuckyStruct {
    value1: i32,
    value2: bool,
}

let default_str = MyLuckyStruct::default();
```

Можно определить вручную:

```rust
impl Default for MyStruct {
    fn default() -> Self {
        Self { value1: 0, value2: false }
    }
}
```





#### Clone

```rust
#[derive(Clone, Default)]
struct MyLuckyStruct {
    value1: i32,
    value2: bool
}

let default_str = MyLuckyStruct::default();
let another_str = default_str.clone();
println!("{}", default_str.value1);
println!("{}", another_str.value1);
```





#### Copy

Требует наличие `clone`.

```rust
#[derive(Copy, Clone, Default)]
struct MyLuckyStruct {
    value1: i32,
    value2: bool
}
let default_str = MyLuckyStruct::default();
let another_str = default_str;
println!("{}", default_str.value1);
println!("{}", another_str.value1);
```







### Array

Не лежит на куче, если это явно не прописано. Живет на стеке или в структуре. 



```rust
let array: [i32; 5] = [1, 2, 3, 4, 5];

let var1 = array[4];

let var2 = array[42];
// error: this operation will panic at runtime

struct MyStructWithArray {
    array: [i32; 5],
}
```





### Vector

Динамический массив. Реализуется через макрос `vec!` -- синтаксический сахар. 

```rust
let mut vec: Vec<i32> = vec![1, 2, 3, 4, 5];
vec.push(42);
let len = vec.len();
println!("{}", vec[3]);
```







### Generics

#### Структуры и метоы

```rust
struct MyPair<T> {
    left: T,
    right: T,
}

impl<T> MyPair<T> {
    fn do_something_with_type(&self) {
        println!("{}", self.left + self.right)
    }
}

let my_small = MyPair::<i8> { left: 42, right: 1 };
let my_big = MyPair::<i128> {
    left: 42424212123123123123123312312312,
    right: 4121234236423648726348263874621,
};
```





#### Функции

```rust
fn generic_function<T>(p1: T, p2: T) -> MyPair<T> {
    MyPair::<T>{
        left: p1,
        right: p2
    }
}
generic_function::<i32>(42, 1);
generic_function(42, 1);
```



##### Multiple generics

```rust
fn generic_function<T, V>(p1: T, p2: T, other: V) -> MyPair<T> {
    MyPair::<T>{
        left: p1,
        right: p2
    }
}
generic_function::<i32, bool>(42, 1, true);
generic_function(42, 1, true);
```



##### Multiple gerenics in impl

```rust
impl<T> MyPair<T> {
    fn new<V>(p1: T, p2: T, other: V) -> Self {
        Self{
            left: p1,
            right: p2
        }
    }
}
let pair = MyPair::<i32>::new::<bool>(42, 1, true);
let pair = MyPair::new(42, 1, true);
```





#### Generic bounds

##### Add

```rust
impl<T: Add> MyPair<T> {
    fn do_summ(self)  {
        let sum = self.left + self.right;
    }
}
```



##### ToString

```rust
trait ToString {
    fn to_string(&self) -> String;
}

impl<T: ToString> MyPair<T> {
    fn print(&self) {
        println!("{}{}", self.left.to_string(), self.right.to_string())
    }
}
```



##### Display

```rust
impl<T: Display> MyPair<T> {
    fn print(&self) {
        println!("{}{}", self.left, self.right)
    }
}

pub trait Display {
    #[stable(feature = "rust1", since = "1.0.0")]
    fn fmt(&self, f: &mut Formatter<'_>) -> Result;
}
```



##### Multiple Bounds

```rust
fn trace<T: Display + Debug>(to_trace: T, verbose: bool) {
    println!("Display: `{}`", to_trace);
    if verbose {
        println!("Debug: `{:?}`", to_trace);
    }
}

#[derive(Debug)]
struct MyPair<T> { left: T, right: T, }
```

Вывод получается такой:

```asciiarmor
> Display: `(42, 1)`
> Debug: `MyPair { left: 42, right: 1 }`
```



###### Where clause

Для лучшей читаемости можно параметризированный тип определить после `where`:

```rust
fn trace_multiple<T: Display + Debug, V: Display + Debug>(to_trace1: T, to_trace2: V) {…

//     ^
//    |||
//     v

fn trace_multiple<T, V>(to_trace1: T, to_trace2: V)
    where
        T: Display + Debug,
        V: Display + Debug {
```











## 23-03-07

### Option

Аналог `null` в расте.  

```rust
fn main() {
    let mut var: Option<i32> = Option::None;
    assert_eq!(true, var.is_none());

    var = Option::Some(42);
    assert_eq!(true, var.is_some());

    print!("{}", var.unwrap());
    // в данном случае, происходит move

    let reference: &i32 = var.as_ref().unwrap();
    // `as_ref` возвращает ссылку на объект
}
```







### How to move data to heap?

Так никто не делает:

```rust
unsafe {
    let layout = Layout::new::<u16>();
    let ptr = alloc(layout);
    
    if ptr.is_null() { // не  получилось выделить память для кучи
        handle_alloc_error(layout);
    }
    
    // кладем значение на кучу
    *(ptr as *mut u16) = 42;
    assert_eq!(*(ptr as *mut u16), 42);

    dealloc(ptr, layout);
}
```

Ну, на самом деле, делает, но такой способ не самый безопасный: нужно не забывать про `dealloc`, следить за указателем `ptr`. 

В расте есть концепция *OBRM -- Ownership Based Resource Management* -- аналог RAII. Общая идея в том, что объект живет между вызывами конструктора и деструктора. 

Вот объект создается на куче. Используется определенное количество ресурсов, на стек кладется сырой указатель. Когда объект умирает, сырой указатель убирается со стека, а занятые ресурсы освобождаются. 





### Linked List: пример плохого кода 

```rust
struct Node<'a> {
    value: i32,
    next: Option<&'a Node<'a>>
}


fn main() {
    let mut node1 = Node { value: 1, next: Option::None };
    {
        let mut node2 = Node { value: 2, next: Option::None };
        {
            let node3 = Node { value: 3, next: Option::None };

            node2.next = Some(&node3);
            node1.next = Some(&node2);

            println!("{}", node1.next.unwrap().next.unwrap().value);
            node1.next = None;
        }
        
    println!("{}", node1.value) // does not compile
    }
}
```

```asciiarmor
error[E0597]: `node3` does not live long enough
   |
14 |             node2.next = Some(&node3);
   |                               ^^^^^^ borrowed value does not live long enough
...
   |         - `node3` dropped here while still borrowed
20 |     println!("{}", node1.value) // does not compile
   |                    ----------- borrow later used here
```

Все ноды получают одинаковый лайфтайм, причем наименьший, поэтому все три ноды умирают внутри третьего скоупа. В строке 21 мы обращаемся к мертвой ноде. 







### Box (unique ownership)

Структура вида `Box<type>`. Внутри бокса хранится ссылка объект, живущий на куче. Создается вызовом функции `Box::new(<object>)`.

`Box` -- это как `smart_ptr`. Кто владеет боксом, тот владеет объектом. 

```rust
struct Node {
    value: i32,
    next: Option<Box<Node>>,
}
```

Теперь нода владеет следующей нодой. Лайфтаймы у нод получаются вложенные, а не равные. 

Удаление последнего элемента не влияет на остальные ноды. Но удаление ноды $N$ в середине листа влечет за собой удаление последующих нод, потому что $N$ (скажем, косвенно) владеет всеми последующими нодами. 

Полный пример кода:

```rust
struct Node {
    value: i32,
    next: Option<Box<Node>>,
}


fn main() {
    let mut root = Box::new(Node {
        value: 1,
        next: Some(
            Box::new(
                Node {
                    value: 2,
                    next: Some(Box::new(Node {
                        value: 3,
                        next: None,
                    })),
                })),
    });
    
    println!("{}", root.next.unwrap().next.unwrap().value);
    
    root.next = None;
    println!("{}", root.value);
}
```





#### Взятие ссылки на значение в боксе

Функции `borrow()` и `borrow_mut()`.

```rust
use std::borrow::Borrow;
use std::borrow::BorrowMut;

struct MyStruct {
    value1: i32,
}

fn main() {
    let mut boxed = Box::new(MyStruct { value1: 42 });
    
    //let reference = boxed.borrow(); // does not compile
                                      // type must be known at this point
    let reference: &MyStruct = boxed.borrow();
    println!("{}", reference.value1);
    
    let mut_reference: &mut MyStruct = boxed.borrow_mut();
    mut_reference.value1 = 123;
}
```







### RC (shared ownership)

`Rc` = reference counter. Можно сделать несколько указателей на один и тот же объект (живущий на куче), и каждый из указателей владеет этим объектом. 

`Rc` -- это как `shared_ptr`. Объект живет, пока есть хотя бы один `Rc`. 

Модифицировать данные внутри `Rc` нельзя.



Пример использования `Rc`:

```rust
use std::rc::Rc;

struct MyStruct {
    value: i32,
}


fn main() {
    let owner1 = Rc::new(MyStruct { value: 42 });
    let owner2: Rc<MyStruct> = owner1.clone();
    let owner3: Rc<MyStruct> = owner2.clone();
    
    println!("{} {} {}", owner1.value, owner2.value, owner3.value);
}
```







### Модуль `std::cell`

Компилятор позволяет иметь одновременно либо несколько немутабельных ссылок (`&`) на объект, либо только одну мутабельную ссылку (`&mut`). Такая мутабельность называется `inherited mutability`. Но это не всегда удобно. 

Контейнеры `Cell` и `RefCell` позволяют изменять объект, даже если на него ссылаются несколько немутабельных ссылок. Такая мутабельность называется `interior mutability`. Мутабельные ссылки получают с помощью метода `borrow()`.







#### Cell

Внутри контейнера хранится сам объект. Умеет мувать значение в контейнер и из него. 

```rust
use std::cell::Cell;
use std::borrow::Borrow;

fn main() {
    let cell = Cell::new(42);
    let ref1: &Cell<i32> = cell.borrow();
    let ref2: &Cell<i32> = cell.borrow();
    println!("{} {}", ref1.get(), ref2.get());
    ref1.replace(123);
    println!("{} {}", ref1.get(), ref2.get());
}
```

Функция `Cell::get()` возвращает копию значения. Работает только на `Copy` объектах. 

Функция `Cell::take()` меняет старое значение на дефолтное и возвращает старое значение. Работает только на `Default` объектах, внутри вызывает функцию `Default::default()`. 

Функция `Cell::replace()` меняет старое значение на новое и возвращает старое значение. 







#### RefCell 

В отличие от простого `Cell`, внутри `RefCell` хранится именно ссылка на структуру. 

```rust
use std::cell::Ref;
use std::cell::RefMut;
use std::cell::RefCell;

struct MyStruct {
    value: i32,
}


fn main() {
    let cell = RefCell::new(MyStruct { value: 42 });
    {
        // немутабельная ссылка на `cell`
        let ref1: Ref<MyStruct> = cell.borrow();
        println!("{}", ref1.value); // > 42
    }
    {
        // мутабельная ссылка на `cell`
        let mut ref_mut: RefMut<MyStruct> = cell.borrow_mut();
        ref_mut.value = 123;
    }
    let ref2: Ref<MyStruct> = cell.borrow();
    println!("{}", ref2.value); // > 123
}
```

Компилятор проверяет, существуют ли одновременно и мутабельные, и немутабельные ссылки. Если убрать вложенные скоупы, код не скомпилится из-за проверок компилятора. 







#### Circular references

```rust
use std::cell::Cell;
use std::rc::Rc;

struct NodeLeft {
    right: Cell<Option<Rc<NodeRight>>>,
}

struct NodeRight {
    left: Cell<Option<Rc<NodeLeft>>>,
}


fn main() {
    let node_left = Rc::new(NodeLeft { right: Cell::new(None) });
    let node_right = Rc::new(NodeRight {
        left: Cell::new(Some(node_left.clone()))
    });
    let e = node_left.right.replace(Some(node_right.clone()));
}
```

Создаем левую ноду. Создаем правую ноду с ссылкой на левую. Потом через метод `replace()` сохраняем внутри левой ноды ссылку на правую. 

Без `Cell` обойтись нельзя, потому что нам нужны мутабельные ссылки.







#### Утечка памяти из-за `Rc`

В коде выше два раза использовалась функция `clone()`. Когда `node_left` и `node_right` будут умирать, сами объекты не умрут, потому что все еще существуют ссылки на них.



##### `Rc::downgrade()`

Чтобы избежать эту проблему, используется `Weak` ссылка. Получить ее из `Rc` можно с помощью `Rc::downgrade()`. 

```rust
use core::cell::Cell;
use std::rc::Rc;
use std::rc::Weak;

struct NodeLeft {
    right: Cell<Option<Rc<NodeRight>>>,
}
struct NodeRight {
    left: Cell<Option<Weak<NodeLeft>>>,
}


fn main() {
    let node_left = Rc::new(NodeLeft { right: Cell::new(None) });
    let node_right = Rc::new(NodeRight {
        left: Cell::new(Some(Rc::downgrade(&node_left)))
    });
    let e = node_left.right.replace(Some(node_right.clone()));
}
```

 



##### `Rc::upgrade()`

Получить `Rc` ссылку из `Weak` ссылки:

```rust
use std::rc::Rc;

fn main() {
    let five = Rc::new(5);
    let weak_five = Rc::downgrade(&five);
    
    // create a new Rc reference 
    let strong_five: Option<Rc<_>> = weak_five.upgrade();
    
    // check if modification succeeded 
    assert!(strong_five.is_some());
    
    drop(strong_five);
    drop(five);
    
    assert!(weak_five.upgrade().is_none());
}
```









## 2023-03-14

### Принципы ООП

#### Инкапсуляция

Это, по сути, изоляция чего-то, чтобы испключить влияние извне. 

Для изоляции полей используют геттеры и сеттере. В расте от такой идеи иногда отказываются.





#### Наследование

В расте реализуется с помощью `trait`. 

```rust
use std::f32::consts::PI;


trait Shape {
    fn area(&self) -> f32;  
}

trait HasAngles: Shape {
    fn angles_count(&self) -> i32;
}


struct Rectangle {
    x: f32,
    y: f32,
}

impl Shape for Rectangle {
    fn area(&self) -> f32 { self.x * self.y }
}

impl HasAngles for Rectangle {
    fn angles_count(&self) -> i32 { 4 }
}


struct Circle { r: f32, }

impl Shape for Circle {
    fn area(&self) -> f32 {
        self.r.powi(2) * PI
    }
}



fn main() {
    let rectangle = Rectangle { x: 3.0, y: 4.0 };
    println!("area of rectangle is {}", rectangle.area());
    println!("amount of angels in rectangle is {}", rectangle.angles_count());
    
    let circle = Circle { r: 3.0 };
    println!("area of circle is {}", circle.area());
    // println!("amount of angels is {}", circle.angles_count());
}
```







##### Множественное наследование 

```rust
trait Flyable {
    fn fly(&self);
}

trait Sayable {
    fn sayHi(&self);
}

trait FlyAndSay: Flyable + Sayable {
    fn dosmth(&self);
} 
```







#### Полиморфизм

Возможность использовать в конкретном контексте объект, который является наследником. 

В расте наследование реализовано не у структур, а у трейтов. И трейты невозможно передать в функцию. 





##### Статический полиморфизм 

В статическом полиморфизме известно на этапе компиляции, какие типы используются в каждом контексте.



###### `impl`

Для статического полиморфиза используется ключевое слово `impl`.

В примере есть мерчендайзеры (работники) и директоры. Мерчендайзера уолить легко, а директор с решением не соглашается. 

```rust
impl Employee for MerchandiserImpl {
    fn fire(&self) { println!("Ok, I am fired :(") }
    ...
}

impl Employee for DirectorImpl {
    fn fire(&self) { println!("No, YOU ARE FIRED") }
    ...
}


// `impl` = ожидается аргумент, у которого реализован трейт `Employee` 
fn do_fire(employee: impl Employee) {
    employee.fire();
}

// ожидается, что у аргумента реализованы трейты `Employee` и `Customer`
fn check_discount(employee: impl Employee + Customer) { ... }
```





##### Динамический полиморфизм 

  Возможность использовать агрументы с типами разных наследников в функциях, где требуется базовый трейт. 



В расте, для реализациия используются dynamically sized types -- типы, размеры которых не известны на этапе компиляции (i.e., `str`). Их информация хранится в друх полях -- указателе на ячейку памяти и переменной с размером. 

Если объект фиксированного размера, его тип наследуется от `Sized`. Если нет, что тип наследуется от `?Sized`:

```rust
fn generic<T> (t: T) {} // фиксированный размер
fn generic<T: Sized> (t: T) {} // то же, что и выше 
fn generic<T: ?Sized> (t: &T) {} // динамический тип
```



В расте элемнты из `Vec` имеют фиксированный размер. Объекты внутри `Box`, наоборот,  динамического размера, а сам `Box` -- это указатель (=> фиксированного размера). 





###### `dyn`

В полиморфизме раста используются `trait objects`, а не сами структуры. Для динамического полиморфизма используется ключевое слово `dyn`. 

Размер трейта должен быть известен на этапе компиляции, поэтому `dyn` трейты оборачиваются в `Box`.

```rust
trait Animal {
    fn eat(&self);
}


struct Herbivore;

impl Animal for Herbivore {
    fn eat(&self) {
        println!("I eat plants");
    }
}


struct Carnivore;

impl Animal for Carnivore {
    fn eat(&self) {
        println!("I eat flesh");
    }
}
```

```rust
fn main() {
    // Create a vector of Animals:
    let mut list: Vec<Box<dyn Animal>> = Vec::new();
    let goat = Herbivore;
    let dog = Carnivore;
    list.push(Box::new(goat));
    list.push(Box::new(dog));

    // Calling eat() for all animals in the list:
    for animal in &list{
        animal.eat();
    }
}
```

Использование динамического полиморфизма в функции: 

```rust
use std::borrow::Borrow;

// реализация структур и трейтов

fn dyn_eat(animal: &dyn Animal) {
    animal.eat();
}

fn main() {
    let list: Vec<Box<dyn Animal>> = vec![
        Box::new(Herbivore),
        Box::new(Carnivore)
    ];
    
    dyn_eat(list[0].borrow());
    dyn_eat(list[1].borrow());
}
```

Динамический полиморфизм дольше по времени, чем статический, потому что сначала узнается тип объекта, потом находится нужная функция в таблице `vtable` (маппинг функций).





##### Static vs dynamic polymorphism

| impl                                                         | dyn                                                          |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| generic                                                      | dynamic dispatch -- диспетчеризация по `vtable`              |
| method can be inlined -- используется прямой указатель на функцию (без `vtable`) | method cannot be inlined -- т.к. используется `vtable`       |
| one pointer -- указатель на метод                            | fat pointer -- хранятся два указателя, на объект и на метод в `vtable` |
| code dublication -- если один трейт и много структур, для каждой структуры нужна своя реализация трейта | no code dublication                                          |





### Трейт `Drop`

Это как деструктор. Трейт `Drop` будет вызван, когда стурктура уничтожается.

```rust
struct A;

impl Drop for A {
    fn drop(&mut self) {
        println!("Dropped")
    }
}

fn main() {
    let a = A;
}
```

```shell
> Dropped
```





#### Прямой вызов `drop()`

```rust
struct A;

impl A {
    fn say_hello(&self) {
        println!("I am A struct");
    }
}

impl Drop for A {
    fn drop(&mut self) {
        println!("Dropped")
    }
}

fn main() {
    let a = A;
    
    // error: explicit destructor calls not allowed
    // a.drop();
    
    // ok
    std::mem::drop(a);
    
    // error: value borrowed here after move
    // a.say_hello();
}
```





#### Drop order 

В структуре поля дропаются в том же порядке, что и создаются. 











## 23-03-21

### Модули или Как компануется приложение раста

Есть package. Внутри него живут crates. Crates делятся на модули.



#### Package

Описывается в файле `Cargo.toml`:

```toml
[package]
name = "hello-world"
version = "0.1.0"
edition = "2021"
```





#### Crates

Crate = единица компиляции. Крейты могут быть

- Binary (скомпилированный файл - `exe`)

  ```toml
  [[bin]]
  name = "create_name"
  path = "src/main.rs"
  ```

- Library (скомпилированный файл - `rlib`)

  ```toml
  [lib]
  name = "create_name"
  path = "src/lib.rs"
  ```



Symbol table -- символьная таблица -- хранит соответствие между символом и строкой. Уменьшает время компиляции

`rlib` -- набор `.o` файлов, метаданных, символьных таблиц. Хранится в виде архива. 

Команда `rustc foo.rs --crate-type rlib` компилирует крейт как либу. 





#### Rustc entity

Изначально у крейта нет собственного имени. Во время компиляции мы можем задать имя импортироемому крейту.

```rust
// foo.rs
pub fn aboba() {
    println!("aboba")
}

// bar.rs
fn main() {
   custom_name::aboba();
}
```

```shell
$ rustc foo.rs --crate-type rlib
> libfoo.rlib

$ rustc bar.rs --extern custom_name=./libfoo.rlib
> bar
```







#### Теперь про модули

Рутовым крейтом считается файл `main.rs`. В него можно импортить другие исходные файлы:

```rust
//features.rs
pub struct MyFeature;
impl MyFeature {
    pub fn print(&self) {
        println!("I am a feature!")
    }
}
```

```rust
// main.rs
mod features; // импорт из файла `features.rs`

fn main() {
    let feature = crate::features::MyFeature;
    feature.print();
}
```





##### Создание

```rust
struct MyStruct0;
mod level1 {
    struct MyStruct1;
    mod level2 {
        struct MyStruct2;
    }
}
```





##### `pub`

У модулей есть уровни доступа. 

По дефолту, элемент из текущего модуля может использовать элементы родительских модулей, но не может использовать элементы дочерних модулей:

```rust
struct MyStruct0;
mod level1 {
    struct MyStruct1;
    mod level2 {
        struct MyStruct2;
    }
    fn test() {
        let parent = crate::level1::MyStruct1;
        let child = crate::level1::level2::MyStruct2;
    }
}
```

```asciiarmor
error[E0603]: unit struct `MyStruct2` is private
    let child = crate::level1::level2::MyStruct2;
                                       ^^^^^^^^^ private unit struct
```



Поменять такое поведение можно с помощью ключевого слова `pub`:

```rust
struct MyStruct0;
mod level1 {
    struct MyStruct1;
    mod level2 {
        pub struct MyStruct2;
    }
    pub fn test() {
        let parent = crate::level1::MyStruct1; // полный путь
        let child = level2::MyStruct2;  // относительный путь
    }
}

fn main() {
    let aboba = crate::level1::level2::MyStruct2;
    crate::level1::test();
}
```





###### `pub(crate)`

Доступ к объекту только внутри текущего трейта (файла).





###### `pub(super)`

Доступ к объекту есть у родительского модуля. 

```rust
mod one {
    pub mod two {
        pub mod three {
            pub(super) fn say_hello() { println!("hello"); }
        } // `three`
        
        pub fn foo() { three::say_hello(); }
    } // `two`
    
    pub fn foo() { two::three::say_hello(); }
} // `one`
```

```asciiarmor
error[E0603]: function `say_hello` is private
   |
15 |    two::three::say_hello();
   |                ^^^^^^^^^ private function
```





###### `pub(self)`

Доступ к объекту только внутри текущего модуля.

```rust
mod outer_mod {
    pub mod inner_mod {
        // can be seen only inside `inner_mod`
        pub(self) fn say_hello() { println!("hello"); }
        
        pub fn foo() { say_hello(); }
    }
    
    pub fn foo() { inner_mod::say_hello(); }
}
```

```asciiarmor
error[E0603]: function `say_hello` is private
   |
14 |    inner_mod::say_hello();
   |               ^^^^^^^^^ private function
```





###### `pub(in path)`

Доступ к объекту есть у модуля `path`. `path` должен быть родителем текущего модуля. 

```rust
mod one {
    pub mod two {
        pub mod three {
            pub(in one) fn say_hello() { println!("hello"); }
        } // `three`
    } // `two`
    pub fn foo() { two::three::say_hello(); }
} // 


fn main() {
    one::foo();
}
```







##### `use`

```rust
// использование `MyStruct` без дальнейшего прописывания полного пути
use crate::level1::level2::level3::MyStruct;
use crate::level1::level2::level3::{MyStruct1, MyStruct2};

// с помощью алиасинга
use crate::level1::level2::level3::MyStruct as Aboba;

// использование всего, что живет в выбранном модуле,
// без прописываня полного пути
use crate::level1::level2::level3::*;
```







##### Импорт крейтов 

Простой пример [здесь](####Теперь про модули).

Если внутри `src` есть еще директории с исходными файлами. 

Для директории `<name>` создаем файл `<name>.rs`, внутри него импортим `rs` файлы, которые живут в директории `<name>`:

<img src="./pics for conspects/RUST/RUST 23-03-21 1.png" alt="RUST 23-03-21 1" style="zoom:80%;" />







### Линковка в стиле `C`

Раст часто используется для взаимодействия с каким-то куском кода на другом языке. 


