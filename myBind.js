Function.prototype.myBind = function(context) {
  return () => this.apply(context);
};
Function.prototype.myBind = function (context, ...args) {
  return (...callArgs) => {
    return this.apply(context, args.concat(callArgs));
  };
};
