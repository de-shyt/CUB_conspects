# Java

*Author: Daria Shutina*



[TOC]

## 23-02-02

### Типизация

#### Статическая и динамическая типизация 

*Статически типизированные* языки чётко определяют типы переменных. Типы проверяются во время компиляции. Код не скомпилируется, если типы не совпадают. 

Каждое выражение в статически типизированном языке относится к определенному типу, который можно определить без запуска кода. Иногда компилятор может сам вывести тип, если он не указан явно. Например, в хаскелле функция `add x y = x + y` принимает числа (и возвращает число), потому что `+` работает только на числах. 

*Динамически типизированные* языки не требуют указывать тип, но и не определяют его сами. Например, в питоне функция `def f(x, y): return x + y` может принимать и числа, и строки. Переменные `x`и `y` имеют разные типы в разные промежутки времени. 

Говорят, что в динамических языках значения обладают типом ($\texttt{1} \Rightarrow \texttt{Integer}$), а переменные и функции — нет (`x` и `y` могут быть чем угодно в примере выше).



#### Сильная и слабая типизация

Типизация сильная, если нет неявных преобразований типов. 

Типизация слабая, если возможны неявные преобразования типов. 

Граница между "сильным" и "слабым" размыта. Мяу.







### О языке

- Кроссплатформенный, преимущественно объектно-ориентированный ЯП. 

- Обладает совместимостью: старый код будет компилироваться на джаве более новой версии либо без изменений, либо с минимальными изменениями. 

- Есть строгая спецификация языка и JVM. У каждой версии своя спецификация.
-  Статическая типизация
- Автоматическое выделение памяти (thanks tgarbage collection)







### Общие слова

`jshell` (джей эс хелл) -- интерактивная штука для мгновенного запуска кода; является REPL (read-evaluate-print-loop).



```java
public class Main {
    public static void main(String[] args) {
        System.out.println("aboba");
    }
}
```

`System.out.println("aboba");` -- это statement.

`System.out.println("aboba")` -- это expression и вызов метода.

`System.out` является *квалификатором* для метода `println` (как и `System`  для `out` в `System.out`).







### Переменные

<img src="./pics for conspects/JA/JA 23-02-04 1.png" alt="JA 23-02-04 1" style="zoom:67%;" />



При объявлении переменной её тип не обязательно писать. Для этого используется `var`:

```java
int x;
x = 5;
var y = 5;
```

Тип выявляется неявно, но нужно обязательно проинициализировать переменную.



Если попытаться вывести непроинициализированную переменную, код не скомпилируется:

```java
int x;
System.out.println(x); // does not compile
```



При передаче переменной в метод значение переменной копируется. Если это ссылочный объект, то внутри него хранится ссылка, следовательно, ссылка и копируется для метода. 







### Целочисленные литералы

| число             | префикс      |
| ----------------- | ------------ |
| int               | -            |
| long              | L            |
| двоичное          | 0b           |
| восьмиричное      | 0 (это ноль) |
| шестнадцатиричное | 0x           |

Чтобы визуально разделить число на фрагменты, можно использовать нижнее подчеркивание: `1_000_000`. 







### Вещественные литералы

| число         | суффикс                        |
| ------------- | ------------------------------ |
| double        | D (1D)                         |
| float         | F (1F)                         |
| с экспонентой | 1.6e-19 = $1,6 \cdot 10^{-19}$ |







### equals()

В случае объектов, в перменной хранится ссылка на него. Получается, что оператор `==` будет сравнивать адреса объектов, а не сами объекты.  

Можно использовать метод `equals()`, живущий в классе `Object`. По умолчанию, он работает, как и оператор `==`, но его можно переопределить:

```java
public class MyClass {
    int id;

    public boolean equals(MyClass otherClass) {
        return this.id ==  otherClass.id;
    }

    public static void main(String[] args) {
        var o1 = new MyClass(); 
        o1.id = 1;
        var o2 = new MyClass(); 
        o2.id = 1;
        System.out.println(o1.equals(o2));
    }
}

```

Дети, всегда используйте метод `equals()`!!







### String pool

String pool -- специальная область для хранения строк, созданная ради экономии памяти. В него помещается нужная строка (если её там не было ранее), и в дальнейшем новые переменные ссылаются на одну и ту же область памяти. 

Если создавать переменную как `new String("aboba")`,  то оператор `new` принудительно создает для строки новую область памяти, не добавляя ее в пулл строк.

У строк есть метод `intern()`. Он проверяет, есть ли строка в пулле; если нет, создаёт её; потом возвращает адрес строки. 

```java
public class Main {
   public static void main(String[] args) {
       var s1 = "aboba";
       var s2 = new String("aboba");
       System.out.println(s1 == s2.intern());
   }
}
```





#### Пример

```java
s1 = "aboba";
s2 = new String("aboba");
```

Выражение `s1 == s2` вернет `false`, потому что у объектов разные адреса. 

Но `s1.equals(s2)`  вернет `true`, потому что у класса `String` переопределен метод `equals`. 

Если при сравнении не важен регистр, можно использовать метод `equalsIgnoreCase()`. 







### Unicode в джаве 

По умолчанию, в джаву добавили только Unicode. От остальных кодировок отказались, чтобы не было путаницы. 



**Некоторые термины Unicode**

сурс: http://www.unicode.org/glossary/

<img src="./pics for conspects/JA/JA 23-02-04 2.png" alt="JA 23-02-04 2" style="zoom:67%;" />

Символы за пределами плоскости 0 называются surrogate pair. Состоят из двух code-юнитов: первый -- high surrogate, второй -- low surrogate. 



Специальные символы в джаве состоят из двух байтов. `char` может содержать только один. Поэтому если хочется использовать какие-то специальные символы, то писать их нужно в `String`, а не в `char`:

```java
public static void main(String[] args) {
    char c = '😀';
    System.out.println(c);  // ==> ?
    String s = "😀";
    System.out.println(s);  // ==> 😀
}
```







### NaN

= Not-A-Number. Используется, чтобы представить математически неопределенное число (i.e. деление на ноль, $\sqrt{-1}$). 

Значение NaN нельзя ни с чем сравнить. Выражение `Float.NaN == Float.NaN` вернет `false`, а `Float.NaN != Float.NaN` вернет `true`. Чтобы проверить, является ли значение NaN, используется метод `Float.isNaN()`.







### Константы времени компиляции

- Литералы (числа, строки)
- Инициализированные final-переменные примитивных типов и типа String, если инициализатор – константа (`final int i = 1;`)
- Операции над константами
- Конкатенация строк
- Скобки
- Условный оператор, если все операнды – константы.







### Type cast (приведение типов)

```java
int x = 128;
byte c = (byte) x;
```







### Преобразование типов

#### Расширяющее

<img src="./pics for conspects/JA/JA 23-02-04 3.png" alt="JA 23-02-04 3" style="zoom:67%;" />

Откуда потеря точности? У `double` есть ограничение на целую часть: она не может быть больше $10^{15}$, потому что чисел после запятой может быть и бесконечное количество. А `long` может быть больше $10^{15}$. 



#### Сжимающее

<img src="./pics for conspects/JA/JA 23-02-04 4.png" alt="JA 23-02-04 4" style="zoom:67%;" />



#### Детали

Расширяющие и сжимающие преобразования требуют явного каста. Но можно написать и так:

```java
final int i = 2;
byte c = i;
```

Это константа времени компиляции. Компилятор неявно преобразует число в нужный тип. 

При этом если значение переменной выйдет за рамки значений типа, к которому кастуем, код не скомпилируется:

```java
final int i = 128;
byte c = i;
// error: incompatible types: possible lossy conversion from int to byte
```







### Преобразования типов в выражениях

- Унарные операции, битовый сдвиг, индекс массива: `byte`, `short`, `char` $\rightarrow$ `int`, остальные не меняются

- Бинарные операции -- есть определённая иерархия:

  1. Любой операнд `double` $\Rightarrow$ другой операнд `double`

  2. Любой операнд `float` $\Rightarrow$ другой операнд `float`

  3. Любой операнд `long` $\Rightarrow$ другой операнд `long`

  4. Иначе оба операнда `int`

     

Данный код не скомпилируется:

```java
byte a1 = 1;
byte a2 = 2;
byte sum = a1 + a2;
// error: incompatible types: possible lossy conversion from int to byte
```





#### Пример

Дети, избегайте разных типов в одном выражении!! 

(используйте промежуточные переменные)

```java
double a = Long.MAX_VALUE;
long b = Long.MAX_VALUE;
int c = 1;

System.out.println(a+b+c); // 1.8446744073709552E19
// a + b -> double (переполнения нет) 
//   + c -> double

System.out.println(c+b+a); // 0.0
// c + b -> long (переполнение)
//   + a -> double
```





#### Замечание

Если операции написаны сокращенно (`+=` вместо `var + var`), компилятор добавляет каст неявно:

```java
byte b = 1;
b = b + 1; // не норм
b += 1;    // норм

char c = 'a';
c *= 1.2; // законно, но втф
```







### Массивы

Массив -- это объект, живущий в на куче. Внутри массива хранятся *ссылки* на другие объекты.   

Длина массива -- всегда константа. Она может быть не известна на этапе компиляции, но после выделения памяти длину массива нельзя поменять. 

```java
int[] oneD = new int[10];

int[] oneD_init = new int[]{1, 2, 3, 4, 5}; 
// длина массива станет известна в момент выполнения этой строки

int[] oneDsimple = {1, 2, 3, 4, 5};

int[][] twoD = new int[2][5];

int[][] twoDsimple = { {1, 2, 3}, {4, 5}, {6} };
// массив ссылок на другие массивы
// длина компонент может быть разная 
```



В памяти массив хранится в таком виде:

```asciiarmor
┌─────────────┬────────────┬───────┬───────┬───────┐
│    type     │   length   │  [0]  │  [1]  │  [2]  │
└─────────────┴────────────┴───────┴───────┴───────┘
```

Размеры двумерных массивов могут по-разному влиять на память. 

`new int[2][500]` займет $4056$ байт:   $2 + 2 \cdot 2 + \textit{память для ячеек}$.  

`new int[500][2]` займет $14016$ байт:   $2 + 500 \cdot 2 + \textit{память для ячеек}$. Тут нужно больше памяти для хранения информации `type+length`.





#### Операции с массивом

Методы класса `Array`: [java.util.Arrays](https://courses.cs.washington.edu/courses/cse341/98au/java/jdk1.2beta4/docs/api/java/util/Arrays.html)

```java
int[][] ints = { {1, 2, 3}, {4, 5}, {6} };

System.out.println(ints.length);

int[][] copy = ints.clone();
// скопировать значения массива. Для двумерных массивов клонируется только верхний слой, в компонентах будут храниться ссылки на те же объекты 

int[][] copyRange = Arrays.copyOfRange(ints, 1, 3);

System.out.println(ints == copy); // false
// `==` сравнивает адреса объектов 

System.out.println(ints.equals(copy)); // false
// по умолчанию, `equals` сравнивает по адресам

System.out.println(Arrays.equals(ints, copy)); // true

System.out.println(ints); // [I@3cb5cdba
// абра кадабра

System.out.println(Arrays.toString(ints)); // [1, 3, 3, 2, 1]
// обычный вывод массива

Arrays.sort(ints);
```









## 23-02-16

### Приоритет операций

<img src="./pics for conspects/JA/JA 23-02-16 1.png" alt="JA 23-02-16 1" style="zoom:67%;" />

Пример тернарного оператора (ternary):

```java
System.out.println(x > 0 ? "positive" : "negative or zero");
```







### Значения по умолчанию в функциях

В джаве нет аргументов по умолчанию, но можно сделать так, с помощью перегрузки метода:

```java
public static void main() {
    class Point {
        int x, y;
        
        void shift(int dx, int dy) {
            x += dx;
            y += dy;
        }
        
        void shift(int dx) {
            shift(dx, 0);
        }
    }
    
    Point p = new Point();
    p.x = 1;
    p.y = 1;
    p.shift(1, 1);
    p.shift(1);
}
```







### Модификатор `static`

 `static` у метода означает, что метод относится к самому типу, а не к инстансу этого типа. То есть статический метод будет общим у всех инстансов. 

<img src="./pics for conspects/JA/JA 23-02-07 1.png" alt="JA 23-02-07 1" style="zoom:67%;" />

В статическом методе не передается ссылка на текущий объект `this` (он же общий), поэтому внутри него нет доступа к нестатическим объектам или нестатическим полям. 

Обычно рекомендуется делать методы статическими, когда они никак не используют состояние объекта.

В джаве без использования класса нельзя даже использовать функцию `main`. Иногда бывает удобным вызывать методы без какого-то конкретного объекта (например, для `main`). Для этого методы классов помечаются `static`. Таким образом мы можем использовать метод, не создавая инстанс класса (вспомним функцию `main`).







### Object

Объект -- область фиксированного размера в куче. Обладает фиксированной структурой, содержит заголовок и набор значений. Порядок данных внутри объекта не определен строго.

Объект любого типа наследуется от типа `java.lang.Object`. 

Значение-ссылка может ссылаться на объект или на null, но не на конкретное поле объекта. Например, нельзя создать ссылку на элемент массива, потому что не понятно, в какой последовательности машина хранит данные в памяти. 





#### Методы Object

Методы, которые есть предопределенные у каждом объекте:

- `toString()` -- можно переопределить. По умолчанию, для классов выводит хэш-код(?), для record классов выводит `<className>[field1=value, field2=value]`
- `equals()` -- можно переопределить
- `hashCode()` -- можно переопределить
- `getClass()` -- final-метод, нельзя переопределить
- `wait()`, `notify()`, `notifyAll` -- для многопоточки. final-методы, нельзя переопределить
- `clone()` -- можно переопределить





#### Классы

##### Создание

```java
class Point {
    int x = 0; // значения по умолчанию
    int y = 0;
    
    Point(int x, int y) {
        this.x = x; // `this.` используется, чтобы как-то различать
        this.y = y; // название поля и название аргумента
    }
    
    // деструкторов в джаве нет
}
```



```java
public static void main(String[] args) {
    Point p1 = new Point(1, 2);
    Point p2 = new Point(3, 4);
    
    // Создали два объекта на куче. В переменных `p1` и `p2`
    // хранятся ссылки на эти объекты. 
    
    p1 = p2;
    // Поменяли ссылку, сохраненную в `p1`. 
    // Теперь нет прямого доступа к первому объекту, 
    // и сборщик мусора уничтожил первый объект. 
}
```





##### Record

Records это неизменяемые дата классы, требующие только тип и имя полей. Используются как замена темплейтам, помогают избежать дублирование кода. 

```java
public record Person (String name, String address) {}
```

У records по умолчанию создаются и определяются:

- публичныq коструктор
- публичные геттеры, сеттеры
- метод `equals()`, который возвращает `true`, если все соответствующие поля будут одинаковые. 
- метод `hashCode()`. Хэш коды будут одинаковые, если все соответствующие поля будут одинаковые.
- метод `toString()`



Можно изменять или добавлять реализацию конструктора:

```java
public record Person(String name, String address) {
    public Person {  // меняет дефолтный конструктор
        Objects.requireNonNull(name);
        Objects.requireNonNull(address);
    }
    
    public Person(String name) {
        this(name, "Unknown");
    }
}
```





###### Статические переменные и методы

```java
public record Person(String name, String address) {
    public static String UNKNOWN_ADDRESS = "Unknown";
    
    public static Person unnamed(String address) {
        return new Person("Unnamed", address);
    }
}
```

Обратиться к ним можно, используя имя record класса:

```java
Person.UNKNOWN_ADDRESS;
Person.unnamed("aboba address");
```





### `instanceof`

Оператор, чтобы проверить, является ли объект инстансом определенного класса:

```java
record Point(int x, int y) {
    void shift(int dx, int dy) {
        x += dx;
        y += dy;
    }
}

public static void process(Object obj) {
    if (obj instanceof Point) {
        Point point = (Point) obj;
        point.shift(1, 1);
    }
}
```



Концепция "instanceof + каст" популярна, поэтому в язык добавили фичу:

```java
if (obj instanceof Point point) {
    point.shift(1, 1);
}
```

Объект `point` создаётся только в том случае, если условие вычисляется в `true`. 







### Интерфейсы

Интерфейс описывает поведение объектов, его реализующих, и способы взаимодействия с такими объектами. Важное отличие интерфейса от класса в том, что интерфейс не определяет внутреннее состояие объекта. Нельзя создать экземпляр интерфейса и в интерфейсе нет контрукторов.

У интерфейса есть методы, абстрактные по умолчанию (нет тела функции). Интерфейс также может содержать константы, обычные и статические методы, вложенные типы. Тела методов существуют только для обычных и статических методов.

Поля в интерфейсе могут быть, но они обязаны быть `static` и`final`.



Интерфейс определяет двухсторонный контракт -- требования к реализации и к использованию. Требования выражаются:

- в сигнатурах методов. Проверяется компилятором. 

- в аннотациях. Проверяются процессорами аннотаций, статическим анализов и т.д. Пример -- Javadoc, комментарии специального формата. 

  Для функции можно расписать, какой аргумент что означает, какой смысл у возвращаемого значения:

  ```java
  /**
   * Returns a sum of double numbers
   * @param a first number
   * @param b second number
   * @return a result
   */
  double sum(double a, double b);
  ```

  

- в документации. Простое описание функицй и методов.







#### Использование `interface`

```java
public interface Swimmable  {
     public void swim();
}

public class Duck implements Swimmable {
    @Override
    public void swim() {
        System.out.println("Уточка, плыви!");
    }
    
    public static void main(String[] args) {
        Duck duck = new Duck();
        duck.swim();
    }
}
```

`Swimmable` -- интерфейс. `Duck` -- класс, объекты которого подходят под описание  интерфейса. В классе должны быть определены все абстрактные методы интерфейса. 

Хорошим тоном считается написать аннотацию`@Override`. Это явное обозначение, что метод переопределен. Если метод с аннотацией не определен в интерфейсе, то будет ошибка компиляции. 

 



#### Абстрактные классы

Обычный абстрактный класс. Нельзя создать экземпляр абстрактного класса. 

В отличие от интерфейса, может содержать поля. 

```java
abstract static class AbstractSwimmable extends Swimmable {
    String name;
    
    @Override
    public void swim() {
        System.out.println(name + ", плыви!");
    }
}
```

Используются для того, чтобы, например, переопределить метод класса Object. Таким образом новое определение смогут использовать все классы, реализующие интерфейс. 







#### Модификатор `final`

`final` класс -- класс, который нельзя унаследовать. 

`final` метод -- метод, который нельзя переопределить. 

`final` переменная -- переменная, значение которой нельзя поменять. 







#### Модификатор `sealed`

Используется для классов или интерфейсов Что-то среднее между final и не-final. Явно определяет список возможных наследников с помощью слова `permits`:

```java
sealed interface Swimmable permits Duck {
    ...
}
```







#### Фабричный метод

Статический метод интерфейса. Часто называется `of` или `from`. Суть этого метода в том, чтобы создать правильный класс в зависимости от того, какие аргументы были переданы. Как бы вместо явного вызова `new` можно вызвать метод. 

```java
interface Vector {
    static Vector of(int x, int y, int z) {
        if (x == 0 && y == 0 && z == 0) {
            return new ZeroVector();
        }
        return new ArrayVector(x, y, z);
    }
}
```







### Enum

Класс, в котором фиксированное количество экземпляров. Экземпляры создаются все сразу при первом обращении к классу. 

```java
enum Weekday {
    MONDAY,
    TUESDAY,
    WEDNESDAY,
    THURSDAY,
    FRIDAY,
    SATURDAY,
    SUNDAY
}
```

Может иметь свои поля, методы и кострукторы. Не может быть унаследован. 

```java
enum Weekday {
    // экземпляры
    MONDAY("MON", false), TUESDAY("TUE", false), 
    WEDNESDAY("WED", false), THURSDAY("THU", false), 
    FRIDAY("FRI", false), SATURDAY("SAT", true), 
    SUNDAY("SUN", true);
    
    // поля
    private final String shortName;
    private final boolean weekend;
    
    // конструктор
    Weekday(String shortName, boolean weekend) {
    	this.shortName = shortName;
    	this.weekend = weekend;
    }
    
    // методы
    public String getShortName() { return shortName; }
    public boolean isWeekend() { return weekend; }
}
```







#### Перечисление

Некоторые полезные методы, сгенерированный компилятором автоматически:

- `<EnumClassName>.values()` -- возвращает массив из всех enum-констант
- `<EnumClassName>.valueOf(String)` -- значение по имени экземпляра (или исключение)
- `<EnumVlalue>.name()` -- узнать имя экземпляра
- `<EnumValue>.original()` -- узнать порядковый номер экземпляра в enum-классе. Индексация начинается с нуля. 







#### switch, используя экземпляры enum-класса

```java
String workingHours(Weekday weekday) {
    return switch (weekday) {
        case MONDAY, FRIDAY -> "9:30-13:00";
        case TUESDAY, THURSDAY -> "14:00-17:30";
        case WEDNESDAY, SATURDAY, SUNDAY -> "Выходной";
    };
}

for (Weekday weekday : Weekday.values()) {
    System.out.println(workingHours(weekday))
}
```







### Пакеты

Пакет -- это объединение классов. Название начинается с маленькой буквы. Чтобы создать пакет, нужно перед определением классов вставить строку 

```java
package packageName;
```

Пакеты должны располагаться в соответствующих директориях, то есть файл пакета `Name` должен быть сохранен в папке `Name`. 

Пакеты могут быть вложенными. По внешнему виду сложно сказать, где класс, а где пакет. Для этого есть договоренность, что пакеты именуются с маленькой буквы, а классы -- с большой.  

<img src="./pics for conspects/JA/JA 23-02-16 2.png" alt="JA 23-02-16 2" style="zoom:60%;" />







### Модули

Модуль -- объединение пакетов. Задаёт явный ациклический граф зависимостей. Обладает сильной инкапсуляцией: если какой-то пакет не экспортирован, то и использовать его не получится. 

```java
module demo {
    requires java.xml;
    requires java.desktop;
    exports com.example.demo; // экспорт пакета
}
```

Название модуля с маленькой буквы.









## 23-02-23

### Исключения

```java
public int get(int index) {
    if (index < 0) {
        throw new IllegalArgumentException("index < 0");
    }
    return array[index];
}
```

В джаве `stack trace` заполняется в момент создания исключения, а не в момент его выкидывания. Это отличает джаву от других языков. Если `new` и `throw` в разных местах кода, может возникнуть непонимание. 

Можно у метода явно указать, что он кидает исключение: 

```java
public int get(int index) throws IllegalArgumentException {
    if (index < 0) {
        throw new IllegalArgumentException("index < 0");
    }
    return array[index];
}
```





#### Иерархия

Главный класс -- `Throwable`. Живет в библиотеке `java.lang.Throwable`. Все исключения, в том числе кастомные, наследуются от него. 

Основные классы исключений представлены на картинке. Голубым отмечены проверяемые исключения (то есть желательно -- но не обязательно, -- чтобы они были указаны после слова `throws`), желтым -- непроверяемые. Суть голубых исключений в том, что 

<img src="./pics for conspects/JA/JA 23-03-03 1.png" alt="JA 23-03-03 1" style="zoom:55%;" />







####  Конструкторы

```java
Throwable();
Throwable(message);  // exception with message
Throwable(message, cause);  // exception with message and cause. Cause is another exception 
                            // which was the reason for throwing currect exception.
```





#### Полезные методы у исключений

```java
Exception exception = new Exception();
exception.getMessage();  // get message of exception
exception.getCause();    // get cause of exception

exception.getStackTrace();  // stack trace is an array of objects. Each object stores name of class, 
                            // name of method and number of line where exception was thrown.

exception.getSuppressed(); // if exception B is thrown inside exception A, exception A will be suppressed and saved. 
```







#### try-catch

```java
public int get(int index) {
    if (index < 0) {
        throw new IllegalArgumentException("get(index = " + index.toString() + "): index < 0\n");
    }
    return array[index];
}

public static void main(String[] args) {
    try {
        get(-1);
    } 
    catch (IllegalArgumentException ex) {
        System.out.println("message: " + ex.getMessage());
        System.out.println(ex.getStackTrace());
    }
}
```

Есть еще ключевое слово `finally`, тогда при любом исходе блок с `finally` будет выполнен:

```java
public static void main(String[] args) {
    try {
        get(-1);
    } 
    catch (IllegalArgumentException ex) {
        System.out.println("message: " + ex.getMessage());
        System.out.println(ex.getStackTrace());
    }
    finally {
        System.out.println("Finishing main\n");
    }
}
```





##### Еще про `finally`

Пример, как не надо делать:

```java
public static int test() {
    try {
    	return 5;
    }
    finally {
    	return 6;
    }
}
```

Функция вернет `6`. Мы заходим в `try` блок и собираемся вернуть `5`. Перед тем, как сработает `return`, мы переходим в блок `finally`.







#### Логирование: пример использования

```java
public class PoolComposerPrincipalEventIdentifier {
    private static final Logger LOG = Logger.getLogger(
    	PoolComposerPrincipalEventIdentifier.class.getName()
    );

    public void identifyPrincipalEvent() {
        try {
        	doIdentifyPrincipalEventUsingPoolComposer();
        }
        catch(Exception ex) {
        	LOG.log(Level.SEVERE, "Error while identifying principal event", ex);
        }
    }
}
```







### Надтипы и подтипы

Если какой-то класс реализует интерфейс, то интерфейс является *надтипом*, а соответствующий класс -- *подтипом*. 

Если класс $A$ расширяет класс $B$, то $B$ -- это *надтип*, а $A$ -- это *подтип*. 

Надтипы и подтипы образуют направленный граф. На них определен частичный порядок. 

Надтип не должен предоставлять больше возможностей,
чем предоставляет подтип (вообще, кажется, это, в принципе, невозможно. У наследников всегда больше функционала, чем у классов, от которых наследуемся). Подтип предоставляет больше конкретики, а надтип -- больше абстракции.

`A extends B` -- `A` является подтипом `B`.

`A super B` -- `A` является надтипом `B`. 

Если тип `Derived` является подтипом  `Base`, это не значит, что `Myclass<Derived>` будет подтипом `MyClass<Base>`.





#### Пример использования `extends`

```java
static double getDoubleValue(Shmoption<Number> shmopt) {
	return shmopt.get().doubleValue();
}

getDoubleValue(new IntegerShmoption(123));
```

Не скомпилится, функция ожидает класс с типом `Number`, а не `Integer`. 

```java
static double getDoubleValue(Shmoption<? extends Number> shmopt) {
	return shmopt.get().doubleValue();
}

getDoubleValue(new IntegerShmoption(123));
// В данном случае тип переданного аргумента -- Integer. 
```

Теперь аргумент функции -- это класс любого типа, который является подтипом `Number`.





####  Пример использования `super`

```java
static void setInteger(Shmoption<Integer> shmopt) {
	shmopt.set(42);
}

NumberShmoption<Number> n = new NumberShmoption<>(123.45);
setInteger(n);
```

Не скомпилится. Функция ожидает класс типа `Integer`.

```java
static void setInteger(Shmoption<? super Integer> shmopt) {
shmopt.set(42);
}
NumberShmoption<Number> n = new NumberShmoption<>(123.45);
setInteger(n);
```

ДТеперь в функцию можно передавать класс с типом, который является надтипом `Integer`. Например, `Double`. 







### Covariant return type

Ковариантность -- это про приведение типов. 

```java
interface Supplier {
	Object get();
}

interface StringSupplier extends Supplier {
    @Override
    String get();
}
```







### Параметризация

#### Параметризация типов

Дженерики -- классы, объявленные обобщенными. Тип дженерика не может быть примитивным (поэтому существуют обертки `Integer`, `Long`, etc).



**Пример**

```java
static class Option<T> {
    private T value;
    
    public Option(T value) { this.value = value; }
    
    /** Never returns null */
    public T get() {
        if(value == null) throw new NoSuchElementException();
        return value;
    }
    public T orElse(T other) { return value == null ? other : value; }
    public boolean isPresent() { return value != null; }
}

public static void main(String[] args) {
    Option<String> aboba = new Option<String>("aboba");
    
    Option<String> abobaImplicit = new Option<>("aboba"); 
    // в джаве 8 придумали оператор ромб:)
    // нет необходимости явно указывать тип в конструкторе
    
    Option<String> abobaImplicit = new Option("aboba"); 
    // raw type. Можно не указывать тип и не использовать `<>`. 
    // нужно избегать их, как огня
}
```

```java
public static void main(String[] args) {
	Option<String> abobaImplicit = new Option<>("aboba"); 
    
    Option<var> abobaImplicit = new Option<>("aboba");
    // бывают ситуации, когда компилятор не справляется определить нужный пользователю тип. 
    // Например, поставит тип Object вместо String. 
    // Поэтому дети, не используйте одновременно `var` и оператор `<>`.
}                                                      

```





##### Маскировочный тип

`?` (wildcard)

`?` $\Leftrightarrow$ используется какой-то тип, который расширяет класс `Object`. 

```java
static class Shmoption<T> {
    T value;
    public Shmoption(T value) { this.value = value; }\
    public T get() {
        if(value == null) throw new NoSuchElementException();
        return value;
    }
    public void set(T newValue) { value = newValue; }
    public T orElse(T other) { return value == null ? other : value; }
    public boolean isPresent() { return value != null; }
}

public static void main(String[] argv) {
    Shmoption<?> present = new Shmoption<>("yes");
    
	System.out.println(present.isPresent()); // в данном случае не зависит от типа элемента
    
	Object value = present.get(); // вернет какой-то тип, не известный. 
                                  // Но мы точно знаем, что это наследник `Object`
    
	present.set(???);  // сработает только с null. 
                       // Тип у объекта `present` не определен, он так и остается `?`.
}
```

Если поставить курсор между скобочками и нажать `ctrl+P`, то идея покажет, аргументы какого типа ожидаются 0_0





###### `? extends Number`

```java
public static void main(String[] argv) {
    Shmoption<? extends Number> number = new Shmoption<>(123);
	Number n = number.get();
	number.set(124);
}
```

В данном случае тип всё еще не известен, но мы точно знаем, что он числовой. Таким образом, метод `get()` возвращает не просто `Object`, а `Number`. 





##### Наследование

```java
// наследник типа Number
class NumberShmoption<N extends Number> extends Shmoption<N> {
	public NumberShmoption(N value) { super(value); }
}

// наследник типа Integer
class IntegerShmoption extends NumberShmoption<Integer> {
	public IntegerShmoption(Integer value) { super(value); }
}
```







#### Параметризация методов

Чаще всего делают статические параметризированные методы. 

```java
static <T> String returnString(T value) {
    return value.toString();
}
```

```java
static <T> void setNotNull(Shmoption<? super T> shmoption, T value) {
	if (value == null) throw new IllegalArgumentException();
	shmoption.set(value);
}

setNotNull(n, 123);
ShmoptionUtils.<Number>setNotNull(n, 123);
```

 Тип указывать не обязательно. Если компилятор не справился самостоятельно вывести тип, его можно указать в `<>`, при этом нужно обязательно указать квалификатор (штука до точки, может быть `this` или название класса, если метод статический). 





#### Дженерики и массивы

Первый вариант не скомпилится не потняно почему. 

Второй вариант скомпилится, потому что в байткоде не будет указан тип

```java
Shmoption<Integer>[] arrayInt = new Shmoption<Integer>[10]; // does not compile
Shmoption<?>[] array = new Shmoption<?>[10]; // OK
```

Еще один вариант создать массив дженериков -- использование сырых типов:

```java
Shmoption<Integer>[] arrayInt = new Shmoption[10]; // raw-type. Получаем предупреждение
Object[] obj = arrayInt;
obj[0] = new Shmoption<>("foo");
Shmoption<Integer> shmoption = arrayInt[0];
Integer x = shmoption.get(); // ClassCastException: в `arrayInt[0]` лежит `String`
System.out.println(x);
```





### Стирание (erasure)

В процессе выполнения программы типовые параметры не существуют (стираются). Есть сами классы, но они не параметризованы с точки зрения виртуальной машины. 

Преобразование типов может быть небезопасным (например, в коде `return (T)obj`; во время исполнения превращается в `return obj;`), это может привести к исплючению `ClassCastException`. 



#### Пример

```java
Shmoption<Integer> integer = new Shmoption<>(10);

Shmoption<String> string = ((Shmoption<String>) integer); 
// ошибка: `Integer` и `String` в разных ветках иерархии

Shmoption<?> any = integer;
Shmoption<String> string2 = (Shmoption<String>) any; 
// скомпилируется, но появится предупреждение,
// потому что в байткоде будет просто `string2 = any`

String s = string2.get(); 
// ClassCastException: внутри `string2` живет `Integer`, а не `String`

NumberShmoption<Integer> number = (NumberShmoption<Integer>)integer; 
// OK
```









## 23-03-02

### `varags`

Переменное число аргументов

```java
static void printAll(Object... objects) {
    for (Object object : objects) {
    	System.out.println(object);
	}
}

printAll("a", 1, "b", 2.0);

Object[] objects = {"a", 1, "b", 2.0};
printAll(objects);

printAll(null, null); // OK. An array of nulls
printAll(null); // does not compile. 
```





#### varargs + generics

```java
static <T> boolean isOneOf(T value, T... options) {
    for (T option : options) {
    	if (Objects.equals(value, option)) return true;
    }
    return false;
}
```

`Objects.equals` использует метод `equals` объекта, но делает это аккуратно: сначала проверяет, что объект не `null`, потом вызывает метод. 

Используя `varargs` и дженерики в методе, можно получить ворнинг типа `unchecked generic array creation for varargs parameter`. Если метод не делает ничего противозаконного, его можно пометить как безопасный с помощью аннотации `@SafeVarargs`:

```java
@SafeVarargs
static <T> boolean isOneOf(T value, T... options) {
    for (T option : options) {
    	if (Objects.equals(value, option)) return true;
    }
    return false;
}

isOneOf(shmoption, new Shmoption<>("foo"),
				   new Shmoption<>("bar"));
```







### Collections

####  Иерархия

Желтым отмечены интерфейсы, зеленым -- абстрактные классы, серым -- конкретные реализации (классы или методы). 

<img src="./pics for conspects/JA/JA 23-03-04 1.png" alt="JA 23-03-04 1" style="zoom:67%;" />







#### Одновременный read & write 

Например, если мы в цикле  `for` обходим элементы коллекции и одновременно с этим модифицируем коллекцию, вылетит исключение `ConcurrentModificationException`:

```java
import java.util.List;
import java.util.ArrayList;

public class MyClass {
    public static void main(String[] args) {
        List<Integer> list = new ArrayList<>(List.of(1, 2, 3));
        for (Integer a : list) {
            System.out.println(a);
            list.add(4);
        }
    }
}
```

```asciiarmor
Exception in thread "main" java.util.ConcurrentModificationException
	at java.base/java.util.ArrayList$Itr.checkForComodification(ArrayList.java:1013)
	at java.base/java.util.ArrayList$Itr.next(ArrayList.java:967)
	at MyClass.main(MyClass.java:7)
```







#### Не надо использовать 

✓Enumeration -> Iterator

✓Vector -> ArrayList

✓Stack -> ArrayDeque

✓Dictionary -> Map

✓Hashtable -> HashMap

✓LinkedList -> ArrayList/ArrayDeque

У штук слева старая реализация, которая может работать долго. 

























