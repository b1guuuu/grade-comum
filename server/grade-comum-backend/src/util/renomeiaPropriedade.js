/* eslint-disable no-prototype-builtins */
// eslint-disable-next-line no-extend-native
Object.prototype.renameProperty = function (oldName, newName) {
  // Do nothing if the names are the same
  if (oldName === newName) {
    return this
  }
  // Check for the old property name to avoid a ReferenceError in strict mode.
  if (this.hasOwnProperty(oldName)) {
    this[newName] = this[oldName]
    delete this[oldName]
  }
  return this
}