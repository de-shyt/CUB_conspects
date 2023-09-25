# Frontend

*Author: Daria Shutina*

[TOC]



## 23-09-08

Basic HTML: [tutorialspoint.com](https://www.tutorialspoint.com/html/)

Спецификация HTML: [w3schools](https://www.w3schools.com/html/default.asp)

[javascripttutorial.net](https://www.javascripttutorial.net/)

Теория по CSS: [web.dev](https://web.dev/learn/css/)







## 23-09-15

### Js questions

`this` используется для ссылки на объект, к которому привязан текущий вызов функции:

```js
class Animal {
  constructor(name) {
    this.name = name;
  }

  speak() {
    console.log(`${this.name} makes a sound`);
  }
}
```

В глобальной области видимости `this` указывает на глобальный объект (например, `window` в браузере), внутри метода объекта он указывает на этот объект, а в функции, вызванной без контекста, `this` может быть не определено или указывать на `undefined`.



`super` используется в классах и конструкторах для вызова методов родительского класса или конструктора родительского класса:

```js
class Dog extends Animal {
  constructor(name, breed) {
    super(name);
    this.breed = breed;
  }

  speak() {
    super.speak();
    console.log(`${this.name} barks`);
  }
}

const dog = new Dog('Fido', 'Labrador');
dog.speak();
```







### `ptototype`





### functions

Lambda:

```js
let add = (x, y) => x + y;

console.log(add(10, 20))
```

