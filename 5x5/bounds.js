// Generated by CoffeeScript 1.7.1
var Foo, bar, foo,
  __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

(typeof window !== "undefined" && window !== null ? window : global).property = 'glocal context';

this.property = 'surrounding context';

Foo = (function() {
  function Foo() {
    this.bar = __bind(this.bar, this);
    this.property = 'instance context';
  }

  Foo.prototype.bar = function() {
    return console.log(this.property);
  };

  return Foo;

})();

foo = new Foo;

bar = foo.bar;

foo.bar();

bar();

//# sourceMappingURL=bounds.map