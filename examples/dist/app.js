// build/dev/javascript/prelude.mjs
class CustomType {
  withFields(fields) {
    let properties = Object.keys(this).map((label) => (label in fields) ? fields[label] : this[label]);
    return new this.constructor(...properties);
  }
}

class List {
  static fromArray(array, tail) {
    let t = tail || new Empty;
    for (let i = array.length - 1;i >= 0; --i) {
      t = new NonEmpty(array[i], t);
    }
    return t;
  }
  [Symbol.iterator]() {
    return new ListIterator(this);
  }
  toArray() {
    return [...this];
  }
  atLeastLength(desired) {
    let current = this;
    while (desired-- > 0 && current)
      current = current.tail;
    return current !== undefined;
  }
  hasLength(desired) {
    let current = this;
    while (desired-- > 0 && current)
      current = current.tail;
    return desired === -1 && current instanceof Empty;
  }
  countLength() {
    let current = this;
    let length = 0;
    while (current) {
      current = current.tail;
      length++;
    }
    return length - 1;
  }
}
function prepend(element, tail) {
  return new NonEmpty(element, tail);
}
function toList(elements, tail) {
  return List.fromArray(elements, tail);
}

class ListIterator {
  #current;
  constructor(current) {
    this.#current = current;
  }
  next() {
    if (this.#current instanceof Empty) {
      return { done: true };
    } else {
      let { head, tail } = this.#current;
      this.#current = tail;
      return { value: head, done: false };
    }
  }
}

class Empty extends List {
}
var List$Empty = () => new Empty;
var List$isEmpty = (value) => value instanceof Empty;

class NonEmpty extends List {
  constructor(head, tail) {
    super();
    this.head = head;
    this.tail = tail;
  }
}
var List$NonEmpty = (head, tail) => new NonEmpty(head, tail);
var List$isNonEmpty = (value) => value instanceof NonEmpty;
var List$NonEmpty$first = (value) => value.head;
var List$NonEmpty$rest = (value) => value.tail;

class BitArray {
  bitSize;
  byteSize;
  bitOffset;
  rawBuffer;
  constructor(buffer, bitSize, bitOffset) {
    if (!(buffer instanceof Uint8Array)) {
      throw globalThis.Error("BitArray can only be constructed from a Uint8Array");
    }
    this.bitSize = bitSize ?? buffer.length * 8;
    this.byteSize = Math.trunc((this.bitSize + 7) / 8);
    this.bitOffset = bitOffset ?? 0;
    if (this.bitSize < 0) {
      throw globalThis.Error(`BitArray bit size is invalid: ${this.bitSize}`);
    }
    if (this.bitOffset < 0 || this.bitOffset > 7) {
      throw globalThis.Error(`BitArray bit offset is invalid: ${this.bitOffset}`);
    }
    if (buffer.length !== Math.trunc((this.bitOffset + this.bitSize + 7) / 8)) {
      throw globalThis.Error("BitArray buffer length is invalid");
    }
    this.rawBuffer = buffer;
  }
  byteAt(index) {
    if (index < 0 || index >= this.byteSize) {
      return;
    }
    return bitArrayByteAt(this.rawBuffer, this.bitOffset, index);
  }
  equals(other) {
    if (this.bitSize !== other.bitSize) {
      return false;
    }
    const wholeByteCount = Math.trunc(this.bitSize / 8);
    if (this.bitOffset === 0 && other.bitOffset === 0) {
      for (let i = 0;i < wholeByteCount; i++) {
        if (this.rawBuffer[i] !== other.rawBuffer[i]) {
          return false;
        }
      }
      const trailingBitsCount = this.bitSize % 8;
      if (trailingBitsCount) {
        const unusedLowBitCount = 8 - trailingBitsCount;
        if (this.rawBuffer[wholeByteCount] >> unusedLowBitCount !== other.rawBuffer[wholeByteCount] >> unusedLowBitCount) {
          return false;
        }
      }
    } else {
      for (let i = 0;i < wholeByteCount; i++) {
        const a = bitArrayByteAt(this.rawBuffer, this.bitOffset, i);
        const b = bitArrayByteAt(other.rawBuffer, other.bitOffset, i);
        if (a !== b) {
          return false;
        }
      }
      const trailingBitsCount = this.bitSize % 8;
      if (trailingBitsCount) {
        const a = bitArrayByteAt(this.rawBuffer, this.bitOffset, wholeByteCount);
        const b = bitArrayByteAt(other.rawBuffer, other.bitOffset, wholeByteCount);
        const unusedLowBitCount = 8 - trailingBitsCount;
        if (a >> unusedLowBitCount !== b >> unusedLowBitCount) {
          return false;
        }
      }
    }
    return true;
  }
  get buffer() {
    if (this.bitOffset !== 0 || this.bitSize % 8 !== 0) {
      throw new globalThis.Error("BitArray.buffer does not support unaligned bit arrays");
    }
    return this.rawBuffer;
  }
  get length() {
    if (this.bitOffset !== 0 || this.bitSize % 8 !== 0) {
      throw new globalThis.Error("BitArray.length does not support unaligned bit arrays");
    }
    return this.rawBuffer.length;
  }
}
function bitArrayByteAt(buffer, bitOffset, index) {
  if (bitOffset === 0) {
    return buffer[index] ?? 0;
  } else {
    const a = buffer[index] << bitOffset & 255;
    const b = buffer[index + 1] >> 8 - bitOffset;
    return a | b;
  }
}

class UtfCodepoint {
  constructor(value) {
    this.value = value;
  }
}
class Result extends CustomType {
  static isResult(data2) {
    return data2 instanceof Result;
  }
}

class Ok extends Result {
  constructor(value) {
    super();
    this[0] = value;
  }
  isOk() {
    return true;
  }
}
var Result$Ok = (value) => new Ok(value);
var Result$isOk = (value) => value instanceof Ok;
var Result$Ok$0 = (value) => value[0];

class Error extends Result {
  constructor(detail) {
    super();
    this[0] = detail;
  }
  isOk() {
    return false;
  }
}
var Result$Error = (detail) => new Error(detail);
function isEqual(x, y) {
  let values = [x, y];
  while (values.length) {
    let a = values.pop();
    let b = values.pop();
    if (a === b)
      continue;
    if (!isObject(a) || !isObject(b))
      return false;
    let unequal = !structurallyCompatibleObjects(a, b) || unequalDates(a, b) || unequalBuffers(a, b) || unequalArrays(a, b) || unequalMaps(a, b) || unequalSets(a, b) || unequalRegExps(a, b);
    if (unequal)
      return false;
    const proto = Object.getPrototypeOf(a);
    if (proto !== null && typeof proto.equals === "function") {
      try {
        if (a.equals(b))
          continue;
        else
          return false;
      } catch {}
    }
    let [keys, get] = getters(a);
    const ka = keys(a);
    const kb = keys(b);
    if (ka.length !== kb.length)
      return false;
    for (let k of ka) {
      values.push(get(a, k), get(b, k));
    }
  }
  return true;
}
function getters(object) {
  if (object instanceof Map) {
    return [(x) => x.keys(), (x, y) => x.get(y)];
  } else {
    let extra = object instanceof globalThis.Error ? ["message"] : [];
    return [(x) => [...extra, ...Object.keys(x)], (x, y) => x[y]];
  }
}
function unequalDates(a, b) {
  return a instanceof Date && (a > b || a < b);
}
function unequalBuffers(a, b) {
  return !(a instanceof BitArray) && a.buffer instanceof ArrayBuffer && a.BYTES_PER_ELEMENT && !(a.byteLength === b.byteLength && a.every((n, i) => n === b[i]));
}
function unequalArrays(a, b) {
  return Array.isArray(a) && a.length !== b.length;
}
function unequalMaps(a, b) {
  return a instanceof Map && a.size !== b.size;
}
function unequalSets(a, b) {
  return a instanceof Set && (a.size != b.size || [...a].some((e) => !b.has(e)));
}
function unequalRegExps(a, b) {
  return a instanceof RegExp && (a.source !== b.source || a.flags !== b.flags);
}
function isObject(a) {
  return typeof a === "object" && a !== null;
}
function structurallyCompatibleObjects(a, b) {
  if (typeof a !== "object" && typeof b !== "object" && (!a || !b))
    return false;
  let nonstructural = [Promise, WeakSet, WeakMap, Function];
  if (nonstructural.some((c) => a instanceof c))
    return false;
  return a.constructor === b.constructor;
}
function remainderInt(a, b) {
  if (b === 0) {
    return 0;
  } else {
    return a % b;
  }
}
function divideInt(a, b) {
  return Math.trunc(divideFloat(a, b));
}
function divideFloat(a, b) {
  if (b === 0) {
    return 0;
  } else {
    return a / b;
  }
}
function makeError(variant, file, module, line, fn, message, extra) {
  let error = new globalThis.Error(message);
  error.gleam_error = variant;
  error.file = file;
  error.module = module;
  error.line = line;
  error.function = fn;
  error.fn = fn;
  for (let k in extra)
    error[k] = extra[k];
  return error;
}
// build/dev/javascript/gleam_stdlib/dict.mjs
var referenceMap = /* @__PURE__ */ new WeakMap;
var tempDataView = /* @__PURE__ */ new DataView(/* @__PURE__ */ new ArrayBuffer(8));
var referenceUID = 0;
function hashByReference(o) {
  const known = referenceMap.get(o);
  if (known !== undefined) {
    return known;
  }
  const hash = referenceUID++;
  if (referenceUID === 2147483647) {
    referenceUID = 0;
  }
  referenceMap.set(o, hash);
  return hash;
}
function hashMerge(a, b) {
  return a ^ b + 2654435769 + (a << 6) + (a >> 2) | 0;
}
function hashString(s) {
  let hash = 0;
  const len = s.length;
  for (let i = 0;i < len; i++) {
    hash = Math.imul(31, hash) + s.charCodeAt(i) | 0;
  }
  return hash;
}
function hashNumber(n) {
  tempDataView.setFloat64(0, n);
  const i = tempDataView.getInt32(0);
  const j = tempDataView.getInt32(4);
  return Math.imul(73244475, i >> 16 ^ i) ^ j;
}
function hashBigInt(n) {
  return hashString(n.toString());
}
function hashObject(o) {
  const proto = Object.getPrototypeOf(o);
  if (proto !== null && typeof proto.hashCode === "function") {
    try {
      const code = o.hashCode(o);
      if (typeof code === "number") {
        return code;
      }
    } catch {}
  }
  if (o instanceof Promise || o instanceof WeakSet || o instanceof WeakMap) {
    return hashByReference(o);
  }
  if (o instanceof Date) {
    return hashNumber(o.getTime());
  }
  let h = 0;
  if (o instanceof ArrayBuffer) {
    o = new Uint8Array(o);
  }
  if (Array.isArray(o) || o instanceof Uint8Array) {
    for (let i = 0;i < o.length; i++) {
      h = Math.imul(31, h) + getHash(o[i]) | 0;
    }
  } else if (o instanceof Set) {
    o.forEach((v) => {
      h = h + getHash(v) | 0;
    });
  } else if (o instanceof Map) {
    o.forEach((v, k) => {
      h = h + hashMerge(getHash(v), getHash(k)) | 0;
    });
  } else {
    const keys = Object.keys(o);
    for (let i = 0;i < keys.length; i++) {
      const k = keys[i];
      const v = o[k];
      h = h + hashMerge(getHash(v), hashString(k)) | 0;
    }
  }
  return h;
}
function getHash(u) {
  if (u === null)
    return 1108378658;
  if (u === undefined)
    return 1108378659;
  if (u === true)
    return 1108378657;
  if (u === false)
    return 1108378656;
  switch (typeof u) {
    case "number":
      return hashNumber(u);
    case "string":
      return hashString(u);
    case "bigint":
      return hashBigInt(u);
    case "object":
      return hashObject(u);
    case "symbol":
      return hashByReference(u);
    case "function":
      return hashByReference(u);
    default:
      return 0;
  }
}

class Dict {
  constructor(size, root) {
    this.size = size;
    this.root = root;
  }
}
var bits = 5;
var mask = (1 << bits) - 1;
var noElementMarker = Symbol();
var generationKey = Symbol();
var emptyNode = /* @__PURE__ */ newNode(0);
var emptyDict = /* @__PURE__ */ new Dict(0, emptyNode);
var errorNil = /* @__PURE__ */ Result$Error(undefined);
function makeNode(generation, datamap, nodemap, data2) {
  return {
    datamap,
    nodemap,
    data: data2,
    [generationKey]: generation
  };
}
function newNode(generation) {
  return makeNode(generation, 0, 0, []);
}
function copyNode(node, generation) {
  if (node[generationKey] === generation) {
    return node;
  }
  const newData = node.data.slice(0);
  return makeNode(generation, node.datamap, node.nodemap, newData);
}
function copyAndSet(node, generation, idx, val) {
  if (node.data[idx] === val) {
    return node;
  }
  node = copyNode(node, generation);
  node.data[idx] = val;
  return node;
}
function copyAndInsertPair(node, generation, bit, idx, key, val) {
  const data2 = node.data;
  const length = data2.length;
  const newData = new Array(length + 2);
  let readIndex = 0;
  let writeIndex = 0;
  while (readIndex < idx)
    newData[writeIndex++] = data2[readIndex++];
  newData[writeIndex++] = key;
  newData[writeIndex++] = val;
  while (readIndex < length)
    newData[writeIndex++] = data2[readIndex++];
  return makeNode(generation, node.datamap | bit, node.nodemap, newData);
}
function make() {
  return emptyDict;
}
function get(dict, key) {
  const result = lookup(dict.root, key, getHash(key));
  return result !== noElementMarker ? Result$Ok(result) : errorNil;
}
function lookup(node, key, hash) {
  for (let shift = 0;shift < 32; shift += bits) {
    const data2 = node.data;
    const bit = hashbit(hash, shift);
    if (node.nodemap & bit) {
      node = data2[data2.length - 1 - index(node.nodemap, bit)];
    } else if (node.datamap & bit) {
      const dataidx = Math.imul(index(node.datamap, bit), 2);
      return isEqual(key, data2[dataidx]) ? data2[dataidx + 1] : noElementMarker;
    } else {
      return noElementMarker;
    }
  }
  const overflow = node.data;
  for (let i = 0;i < overflow.length; i += 2) {
    if (isEqual(key, overflow[i])) {
      return overflow[i + 1];
    }
  }
  return noElementMarker;
}
function toTransient(dict) {
  return {
    generation: nextGeneration(dict),
    root: dict.root,
    size: dict.size,
    dict
  };
}
function nextGeneration(dict) {
  const root = dict.root;
  if (root[generationKey] < Number.MAX_SAFE_INTEGER) {
    return root[generationKey] + 1;
  }
  const queue = [root];
  while (queue.length) {
    const node = queue.pop();
    node[generationKey] = 0;
    const nodeStart = data.length - popcount(node.nodemap);
    for (let i = nodeStart;i < node.data.length; ++i) {
      queue.push(node.data[i]);
    }
  }
  return 1;
}
var globalTransient = /* @__PURE__ */ toTransient(emptyDict);
function insert(dict, key, value) {
  globalTransient.generation = nextGeneration(dict);
  globalTransient.size = dict.size;
  const hash = getHash(key);
  const root = insertIntoNode(globalTransient, dict.root, key, value, hash, 0);
  if (root === dict.root) {
    return dict;
  }
  return new Dict(globalTransient.size, root);
}
function insertIntoNode(transient, node, key, value, hash, shift) {
  const data2 = node.data;
  const generation = transient.generation;
  if (shift > 32) {
    for (let i = 0;i < data2.length; i += 2) {
      if (isEqual(key, data2[i])) {
        return copyAndSet(node, generation, i + 1, value);
      }
    }
    transient.size += 1;
    return copyAndInsertPair(node, generation, 0, data2.length, key, value);
  }
  const bit = hashbit(hash, shift);
  if (node.nodemap & bit) {
    const nodeidx2 = data2.length - 1 - index(node.nodemap, bit);
    let child2 = data2[nodeidx2];
    child2 = insertIntoNode(transient, child2, key, value, hash, shift + bits);
    return copyAndSet(node, generation, nodeidx2, child2);
  }
  const dataidx = Math.imul(index(node.datamap, bit), 2);
  if ((node.datamap & bit) === 0) {
    transient.size += 1;
    return copyAndInsertPair(node, generation, bit, dataidx, key, value);
  }
  if (isEqual(key, data2[dataidx])) {
    return copyAndSet(node, generation, dataidx + 1, value);
  }
  const childShift = shift + bits;
  let child = emptyNode;
  child = insertIntoNode(transient, child, key, value, hash, childShift);
  const key2 = data2[dataidx];
  const value2 = data2[dataidx + 1];
  const hash2 = getHash(key2);
  child = insertIntoNode(transient, child, key2, value2, hash2, childShift);
  transient.size -= 1;
  const length = data2.length;
  const nodeidx = length - 1 - index(node.nodemap, bit);
  const newData = new Array(length - 1);
  let readIndex = 0;
  let writeIndex = 0;
  while (readIndex < dataidx)
    newData[writeIndex++] = data2[readIndex++];
  readIndex += 2;
  while (readIndex <= nodeidx)
    newData[writeIndex++] = data2[readIndex++];
  newData[writeIndex++] = child;
  while (readIndex < length)
    newData[writeIndex++] = data2[readIndex++];
  return makeNode(generation, node.datamap ^ bit, node.nodemap | bit, newData);
}
function fold(dict, state, fun) {
  const queue = [dict.root];
  while (queue.length) {
    const node = queue.pop();
    const data2 = node.data;
    const edgesStart = data2.length - popcount(node.nodemap);
    for (let i = 0;i < edgesStart; i += 2) {
      state = fun(state, data2[i], data2[i + 1]);
    }
    for (let i = edgesStart;i < data2.length; ++i) {
      queue.push(data2[i]);
    }
  }
  return state;
}
function popcount(n) {
  n -= n >>> 1 & 1431655765;
  n = (n & 858993459) + (n >>> 2 & 858993459);
  return Math.imul(n + (n >>> 4) & 252645135, 16843009) >>> 24;
}
function index(bitmap, bit) {
  return popcount(bitmap & bit - 1);
}
function hashbit(hash, shift) {
  return 1 << (hash >>> shift & mask);
}

// build/dev/javascript/gleam_stdlib/gleam/option.mjs
class Some extends CustomType {
  constructor($0) {
    super();
    this[0] = $0;
  }
}
var Option$isSome = (value) => value instanceof Some;
var Option$Some$0 = (value) => value[0];

class None extends CustomType {
}
function or(first, second) {
  if (first instanceof Some) {
    return first;
  } else {
    return second;
  }
}

// build/dev/javascript/gleam_stdlib/gleam/dict.mjs
function keys(dict) {
  return fold(dict, toList([]), (acc, key, _) => {
    return prepend(key, acc);
  });
}

// build/dev/javascript/gleam_stdlib/gleam/order.mjs
class Lt extends CustomType {
}
var Order$Lt = () => new Lt;
class Eq extends CustomType {
}
var Order$Eq = () => new Eq;
class Gt extends CustomType {
}
var Order$Gt = () => new Gt;

// build/dev/javascript/gleam_stdlib/gleam/list.mjs
class Ascending extends CustomType {
}

class Descending extends CustomType {
}
function reverse_and_prepend(loop$prefix, loop$suffix) {
  while (true) {
    let prefix = loop$prefix;
    let suffix = loop$suffix;
    if (prefix instanceof Empty) {
      return suffix;
    } else {
      let first$1 = prefix.head;
      let rest$1 = prefix.tail;
      loop$prefix = rest$1;
      loop$suffix = prepend(first$1, suffix);
    }
  }
}
function reverse(list) {
  return reverse_and_prepend(list, toList([]));
}
function first(list) {
  if (list instanceof Empty) {
    return new Error(undefined);
  } else {
    let first$1 = list.head;
    return new Ok(first$1);
  }
}
function filter_loop(loop$list, loop$fun, loop$acc) {
  while (true) {
    let list = loop$list;
    let fun = loop$fun;
    let acc = loop$acc;
    if (list instanceof Empty) {
      return reverse(acc);
    } else {
      let first$1 = list.head;
      let rest$1 = list.tail;
      let _block;
      let $ = fun(first$1);
      if ($) {
        _block = prepend(first$1, acc);
      } else {
        _block = acc;
      }
      let new_acc = _block;
      loop$list = rest$1;
      loop$fun = fun;
      loop$acc = new_acc;
    }
  }
}
function filter(list, predicate) {
  return filter_loop(list, predicate, toList([]));
}
function map_loop(loop$list, loop$fun, loop$acc) {
  while (true) {
    let list = loop$list;
    let fun = loop$fun;
    let acc = loop$acc;
    if (list instanceof Empty) {
      return reverse(acc);
    } else {
      let first$1 = list.head;
      let rest$1 = list.tail;
      loop$list = rest$1;
      loop$fun = fun;
      loop$acc = prepend(fun(first$1), acc);
    }
  }
}
function map2(list, fun) {
  return map_loop(list, fun, toList([]));
}
function append_loop(loop$first, loop$second) {
  while (true) {
    let first2 = loop$first;
    let second = loop$second;
    if (first2 instanceof Empty) {
      return second;
    } else {
      let first$1 = first2.head;
      let rest$1 = first2.tail;
      loop$first = rest$1;
      loop$second = prepend(first$1, second);
    }
  }
}
function append(first2, second) {
  return append_loop(reverse(first2), second);
}
function prepend2(list, item) {
  return prepend(item, list);
}
function flatten_loop(loop$lists, loop$acc) {
  while (true) {
    let lists = loop$lists;
    let acc = loop$acc;
    if (lists instanceof Empty) {
      return reverse(acc);
    } else {
      let list = lists.head;
      let further_lists = lists.tail;
      loop$lists = further_lists;
      loop$acc = reverse_and_prepend(list, acc);
    }
  }
}
function flatten(lists) {
  return flatten_loop(lists, toList([]));
}
function fold2(loop$list, loop$initial, loop$fun) {
  while (true) {
    let list = loop$list;
    let initial = loop$initial;
    let fun = loop$fun;
    if (list instanceof Empty) {
      return initial;
    } else {
      let first$1 = list.head;
      let rest$1 = list.tail;
      loop$list = rest$1;
      loop$initial = fun(initial, first$1);
      loop$fun = fun;
    }
  }
}
function find(loop$list, loop$is_desired) {
  while (true) {
    let list = loop$list;
    let is_desired = loop$is_desired;
    if (list instanceof Empty) {
      return new Error(undefined);
    } else {
      let first$1 = list.head;
      let rest$1 = list.tail;
      let $ = is_desired(first$1);
      if ($) {
        return new Ok(first$1);
      } else {
        loop$list = rest$1;
        loop$is_desired = is_desired;
      }
    }
  }
}
function sequences(loop$list, loop$compare, loop$growing, loop$direction, loop$prev, loop$acc) {
  while (true) {
    let list = loop$list;
    let compare2 = loop$compare;
    let growing = loop$growing;
    let direction = loop$direction;
    let prev = loop$prev;
    let acc = loop$acc;
    let growing$1 = prepend(prev, growing);
    if (list instanceof Empty) {
      if (direction instanceof Ascending) {
        return prepend(reverse(growing$1), acc);
      } else {
        return prepend(growing$1, acc);
      }
    } else {
      let new$1 = list.head;
      let rest$1 = list.tail;
      let $ = compare2(prev, new$1);
      if (direction instanceof Ascending) {
        if ($ instanceof Lt) {
          loop$list = rest$1;
          loop$compare = compare2;
          loop$growing = growing$1;
          loop$direction = direction;
          loop$prev = new$1;
          loop$acc = acc;
        } else if ($ instanceof Eq) {
          loop$list = rest$1;
          loop$compare = compare2;
          loop$growing = growing$1;
          loop$direction = direction;
          loop$prev = new$1;
          loop$acc = acc;
        } else {
          let _block;
          if (direction instanceof Ascending) {
            _block = prepend(reverse(growing$1), acc);
          } else {
            _block = prepend(growing$1, acc);
          }
          let acc$1 = _block;
          if (rest$1 instanceof Empty) {
            return prepend(toList([new$1]), acc$1);
          } else {
            let next = rest$1.head;
            let rest$2 = rest$1.tail;
            let _block$1;
            let $1 = compare2(new$1, next);
            if ($1 instanceof Lt) {
              _block$1 = new Ascending;
            } else if ($1 instanceof Eq) {
              _block$1 = new Ascending;
            } else {
              _block$1 = new Descending;
            }
            let direction$1 = _block$1;
            loop$list = rest$2;
            loop$compare = compare2;
            loop$growing = toList([new$1]);
            loop$direction = direction$1;
            loop$prev = next;
            loop$acc = acc$1;
          }
        }
      } else if ($ instanceof Lt) {
        let _block;
        if (direction instanceof Ascending) {
          _block = prepend(reverse(growing$1), acc);
        } else {
          _block = prepend(growing$1, acc);
        }
        let acc$1 = _block;
        if (rest$1 instanceof Empty) {
          return prepend(toList([new$1]), acc$1);
        } else {
          let next = rest$1.head;
          let rest$2 = rest$1.tail;
          let _block$1;
          let $1 = compare2(new$1, next);
          if ($1 instanceof Lt) {
            _block$1 = new Ascending;
          } else if ($1 instanceof Eq) {
            _block$1 = new Ascending;
          } else {
            _block$1 = new Descending;
          }
          let direction$1 = _block$1;
          loop$list = rest$2;
          loop$compare = compare2;
          loop$growing = toList([new$1]);
          loop$direction = direction$1;
          loop$prev = next;
          loop$acc = acc$1;
        }
      } else if ($ instanceof Eq) {
        let _block;
        if (direction instanceof Ascending) {
          _block = prepend(reverse(growing$1), acc);
        } else {
          _block = prepend(growing$1, acc);
        }
        let acc$1 = _block;
        if (rest$1 instanceof Empty) {
          return prepend(toList([new$1]), acc$1);
        } else {
          let next = rest$1.head;
          let rest$2 = rest$1.tail;
          let _block$1;
          let $1 = compare2(new$1, next);
          if ($1 instanceof Lt) {
            _block$1 = new Ascending;
          } else if ($1 instanceof Eq) {
            _block$1 = new Ascending;
          } else {
            _block$1 = new Descending;
          }
          let direction$1 = _block$1;
          loop$list = rest$2;
          loop$compare = compare2;
          loop$growing = toList([new$1]);
          loop$direction = direction$1;
          loop$prev = next;
          loop$acc = acc$1;
        }
      } else {
        loop$list = rest$1;
        loop$compare = compare2;
        loop$growing = growing$1;
        loop$direction = direction;
        loop$prev = new$1;
        loop$acc = acc;
      }
    }
  }
}
function merge_ascendings(loop$list1, loop$list2, loop$compare, loop$acc) {
  while (true) {
    let list1 = loop$list1;
    let list2 = loop$list2;
    let compare2 = loop$compare;
    let acc = loop$acc;
    if (list1 instanceof Empty) {
      let list = list2;
      return reverse_and_prepend(list, acc);
    } else if (list2 instanceof Empty) {
      let list = list1;
      return reverse_and_prepend(list, acc);
    } else {
      let first1 = list1.head;
      let rest1 = list1.tail;
      let first2 = list2.head;
      let rest2 = list2.tail;
      let $ = compare2(first1, first2);
      if ($ instanceof Lt) {
        loop$list1 = rest1;
        loop$list2 = list2;
        loop$compare = compare2;
        loop$acc = prepend(first1, acc);
      } else if ($ instanceof Eq) {
        loop$list1 = list1;
        loop$list2 = rest2;
        loop$compare = compare2;
        loop$acc = prepend(first2, acc);
      } else {
        loop$list1 = list1;
        loop$list2 = rest2;
        loop$compare = compare2;
        loop$acc = prepend(first2, acc);
      }
    }
  }
}
function merge_ascending_pairs(loop$sequences, loop$compare, loop$acc) {
  while (true) {
    let sequences2 = loop$sequences;
    let compare2 = loop$compare;
    let acc = loop$acc;
    if (sequences2 instanceof Empty) {
      return reverse(acc);
    } else {
      let $ = sequences2.tail;
      if ($ instanceof Empty) {
        let sequence = sequences2.head;
        return reverse(prepend(reverse(sequence), acc));
      } else {
        let ascending1 = sequences2.head;
        let ascending2 = $.head;
        let rest$1 = $.tail;
        let descending = merge_ascendings(ascending1, ascending2, compare2, toList([]));
        loop$sequences = rest$1;
        loop$compare = compare2;
        loop$acc = prepend(descending, acc);
      }
    }
  }
}
function merge_descendings(loop$list1, loop$list2, loop$compare, loop$acc) {
  while (true) {
    let list1 = loop$list1;
    let list2 = loop$list2;
    let compare2 = loop$compare;
    let acc = loop$acc;
    if (list1 instanceof Empty) {
      let list = list2;
      return reverse_and_prepend(list, acc);
    } else if (list2 instanceof Empty) {
      let list = list1;
      return reverse_and_prepend(list, acc);
    } else {
      let first1 = list1.head;
      let rest1 = list1.tail;
      let first2 = list2.head;
      let rest2 = list2.tail;
      let $ = compare2(first1, first2);
      if ($ instanceof Lt) {
        loop$list1 = list1;
        loop$list2 = rest2;
        loop$compare = compare2;
        loop$acc = prepend(first2, acc);
      } else if ($ instanceof Eq) {
        loop$list1 = rest1;
        loop$list2 = list2;
        loop$compare = compare2;
        loop$acc = prepend(first1, acc);
      } else {
        loop$list1 = rest1;
        loop$list2 = list2;
        loop$compare = compare2;
        loop$acc = prepend(first1, acc);
      }
    }
  }
}
function merge_descending_pairs(loop$sequences, loop$compare, loop$acc) {
  while (true) {
    let sequences2 = loop$sequences;
    let compare2 = loop$compare;
    let acc = loop$acc;
    if (sequences2 instanceof Empty) {
      return reverse(acc);
    } else {
      let $ = sequences2.tail;
      if ($ instanceof Empty) {
        let sequence = sequences2.head;
        return reverse(prepend(reverse(sequence), acc));
      } else {
        let descending1 = sequences2.head;
        let descending2 = $.head;
        let rest$1 = $.tail;
        let ascending = merge_descendings(descending1, descending2, compare2, toList([]));
        loop$sequences = rest$1;
        loop$compare = compare2;
        loop$acc = prepend(ascending, acc);
      }
    }
  }
}
function merge_all(loop$sequences, loop$direction, loop$compare) {
  while (true) {
    let sequences2 = loop$sequences;
    let direction = loop$direction;
    let compare2 = loop$compare;
    if (sequences2 instanceof Empty) {
      return sequences2;
    } else if (direction instanceof Ascending) {
      let $ = sequences2.tail;
      if ($ instanceof Empty) {
        let sequence = sequences2.head;
        return sequence;
      } else {
        let sequences$1 = merge_ascending_pairs(sequences2, compare2, toList([]));
        loop$sequences = sequences$1;
        loop$direction = new Descending;
        loop$compare = compare2;
      }
    } else {
      let $ = sequences2.tail;
      if ($ instanceof Empty) {
        let sequence = sequences2.head;
        return reverse(sequence);
      } else {
        let sequences$1 = merge_descending_pairs(sequences2, compare2, toList([]));
        loop$sequences = sequences$1;
        loop$direction = new Ascending;
        loop$compare = compare2;
      }
    }
  }
}
function sort(list, compare2) {
  if (list instanceof Empty) {
    return list;
  } else {
    let $ = list.tail;
    if ($ instanceof Empty) {
      return list;
    } else {
      let x = list.head;
      let y = $.head;
      let rest$1 = $.tail;
      let _block;
      let $1 = compare2(x, y);
      if ($1 instanceof Lt) {
        _block = new Ascending;
      } else if ($1 instanceof Eq) {
        _block = new Ascending;
      } else {
        _block = new Descending;
      }
      let direction = _block;
      let sequences$1 = sequences(rest$1, compare2, toList([x]), direction, y, toList([]));
      return merge_all(sequences$1, new Ascending, compare2);
    }
  }
}
function each(loop$list, loop$f) {
  while (true) {
    let list = loop$list;
    let f = loop$f;
    if (list instanceof Empty) {
      return;
    } else {
      let first$1 = list.head;
      let rest$1 = list.tail;
      f(first$1);
      loop$list = rest$1;
      loop$f = f;
    }
  }
}

// build/dev/javascript/gleam_stdlib/gleam/string.mjs
function slice(string, idx, len) {
  let $ = len <= 0;
  if ($) {
    return "";
  } else {
    let $1 = idx < 0;
    if ($1) {
      let translated_idx = string_length(string) + idx;
      let $2 = translated_idx < 0;
      if ($2) {
        return "";
      } else {
        return string_grapheme_slice(string, translated_idx, len);
      }
    } else {
      return string_grapheme_slice(string, idx, len);
    }
  }
}
function drop_end(string, num_graphemes) {
  let $ = num_graphemes <= 0;
  if ($) {
    return string;
  } else {
    return slice(string, 0, string_length(string) - num_graphemes);
  }
}
function concat_loop(loop$strings, loop$accumulator) {
  while (true) {
    let strings = loop$strings;
    let accumulator = loop$accumulator;
    if (strings instanceof Empty) {
      return accumulator;
    } else {
      let string = strings.head;
      let strings$1 = strings.tail;
      loop$strings = strings$1;
      loop$accumulator = accumulator + string;
    }
  }
}
function concat2(strings) {
  return concat_loop(strings, "");
}
function repeat_loop(loop$times, loop$doubling_acc, loop$acc) {
  while (true) {
    let times = loop$times;
    let doubling_acc = loop$doubling_acc;
    let acc = loop$acc;
    let _block;
    let $ = times % 2;
    if ($ === 0) {
      _block = acc;
    } else {
      _block = acc + doubling_acc;
    }
    let acc$1 = _block;
    let times$1 = globalThis.Math.trunc(times / 2);
    let $1 = times$1 <= 0;
    if ($1) {
      return acc$1;
    } else {
      loop$times = times$1;
      loop$doubling_acc = doubling_acc + doubling_acc;
      loop$acc = acc$1;
    }
  }
}
function repeat(string, times) {
  let $ = times <= 0;
  if ($) {
    return "";
  } else {
    return repeat_loop(times, string, "");
  }
}
function padding(size2, pad_string) {
  let pad_string_length = string_length(pad_string);
  let num_pads = divideInt(size2, pad_string_length);
  let extra = remainderInt(size2, pad_string_length);
  return repeat(pad_string, num_pads) + slice(pad_string, 0, extra);
}
function pad_start(string, desired_length, pad_string) {
  let current_length = string_length(string);
  let to_pad_length = desired_length - current_length;
  let $ = to_pad_length <= 0;
  if ($) {
    return string;
  } else {
    return padding(to_pad_length, pad_string) + string;
  }
}
function split2(x, substring) {
  if (substring === "") {
    return graphemes(x);
  } else {
    let _pipe = x;
    let _pipe$1 = identity(_pipe);
    let _pipe$2 = split(_pipe$1, substring);
    return map2(_pipe$2, identity);
  }
}

// build/dev/javascript/gleam_stdlib/gleam/dynamic/decode.mjs
class Decoder extends CustomType {
  constructor(function$) {
    super();
    this.function = function$;
  }
}
function run(data2, decoder) {
  let $ = decoder.function(data2);
  let maybe_invalid_data;
  let errors;
  maybe_invalid_data = $[0];
  errors = $[1];
  if (errors instanceof Empty) {
    return new Ok(maybe_invalid_data);
  } else {
    return new Error(errors);
  }
}
function success(data2) {
  return new Decoder((_) => {
    return [data2, toList([])];
  });
}
function map3(decoder, transformer) {
  return new Decoder((d) => {
    let $ = decoder.function(d);
    let data2;
    let errors;
    data2 = $[0];
    errors = $[1];
    return [transformer(data2), errors];
  });
}

// build/dev/javascript/gleam_stdlib/gleam_stdlib.mjs
var Nil = undefined;
function identity(x) {
  return x;
}
function parse_int(value) {
  if (/^[-+]?(\d+)$/.test(value)) {
    return Result$Ok(parseInt(value));
  } else {
    return Result$Error(Nil);
  }
}
function to_string(term) {
  return term.toString();
}
function string_length(string2) {
  if (string2 === "") {
    return 0;
  }
  const iterator = graphemes_iterator(string2);
  if (iterator) {
    let i = 0;
    for (const _ of iterator) {
      i++;
    }
    return i;
  } else {
    return string2.match(/./gsu).length;
  }
}
function graphemes(string2) {
  const iterator = graphemes_iterator(string2);
  if (iterator) {
    return arrayToList(Array.from(iterator).map((item) => item.segment));
  } else {
    return arrayToList(string2.match(/./gsu));
  }
}
var segmenter = undefined;
function graphemes_iterator(string2) {
  if (globalThis.Intl && Intl.Segmenter) {
    segmenter ||= new Intl.Segmenter;
    return segmenter.segment(string2)[Symbol.iterator]();
  }
}
function uppercase(string2) {
  return string2.toUpperCase();
}
function split(xs, pattern) {
  return arrayToList(xs.split(pattern));
}
function string_grapheme_slice(string2, idx, len) {
  if (len <= 0 || idx >= string2.length) {
    return "";
  }
  const iterator = graphemes_iterator(string2);
  if (iterator) {
    while (idx-- > 0) {
      iterator.next();
    }
    let result = "";
    while (len-- > 0) {
      const v = iterator.next().value;
      if (v === undefined) {
        break;
      }
      result += v.segment;
    }
    return result;
  } else {
    return string2.match(/./gsu).slice(idx, idx + len).join("");
  }
}
function starts_with(haystack, needle) {
  return haystack.startsWith(needle);
}
function ends_with(haystack, needle) {
  return haystack.endsWith(needle);
}
var unicode_whitespaces = [
  " ",
  "\t",
  `
`,
  "\v",
  "\f",
  "\r",
  "",
  "\u2028",
  "\u2029"
].join("");
var trim_start_regex = /* @__PURE__ */ new RegExp(`^[${unicode_whitespaces}]*`);
var trim_end_regex = /* @__PURE__ */ new RegExp(`[${unicode_whitespaces}]*$`);
var MIN_I32 = -(2 ** 31);
var MAX_I32 = 2 ** 31 - 1;
var U32 = 2 ** 32;
var MAX_SAFE = Number.MAX_SAFE_INTEGER;
var MIN_SAFE = Number.MIN_SAFE_INTEGER;
function float_to_string(float2) {
  const string2 = float2.toString().replace("+", "");
  if (string2.indexOf(".") >= 0) {
    return string2;
  } else {
    const index3 = string2.indexOf("e");
    if (index3 >= 0) {
      return string2.slice(0, index3) + ".0" + string2.slice(index3);
    } else {
      return string2 + ".0";
    }
  }
}

class Inspector {
  #references = new Set;
  inspect(v) {
    const t = typeof v;
    if (v === true)
      return "True";
    if (v === false)
      return "False";
    if (v === null)
      return "//js(null)";
    if (v === undefined)
      return "Nil";
    if (t === "string")
      return this.#string(v);
    if (t === "bigint" || Number.isInteger(v))
      return v.toString();
    if (t === "number")
      return float_to_string(v);
    if (v instanceof UtfCodepoint)
      return this.#utfCodepoint(v);
    if (v instanceof BitArray)
      return this.#bit_array(v);
    if (v instanceof RegExp)
      return `//js(${v})`;
    if (v instanceof Date)
      return `//js(Date("${v.toISOString()}"))`;
    if (v instanceof globalThis.Error)
      return `//js(${v.toString()})`;
    if (v instanceof Function) {
      const args = [];
      for (const i of Array(v.length).keys())
        args.push(String.fromCharCode(i + 97));
      return `//fn(${args.join(", ")}) { ... }`;
    }
    if (this.#references.size === this.#references.add(v).size) {
      return "//js(circular reference)";
    }
    let printed;
    if (Array.isArray(v)) {
      printed = `#(${v.map((v2) => this.inspect(v2)).join(", ")})`;
    } else if (isList(v)) {
      printed = this.#list(v);
    } else if (v instanceof CustomType) {
      printed = this.#customType(v);
    } else if (v instanceof Dict) {
      printed = this.#dict(v);
    } else if (v instanceof Set) {
      return `//js(Set(${[...v].map((v2) => this.inspect(v2)).join(", ")}))`;
    } else {
      printed = this.#object(v);
    }
    this.#references.delete(v);
    return printed;
  }
  #object(v) {
    const name = Object.getPrototypeOf(v)?.constructor?.name || "Object";
    const props = [];
    for (const k of Object.keys(v)) {
      props.push(`${this.inspect(k)}: ${this.inspect(v[k])}`);
    }
    const body = props.length ? " " + props.join(", ") + " " : "";
    const head = name === "Object" ? "" : name + " ";
    return `//js(${head}{${body}})`;
  }
  #dict(map4) {
    let body = "dict.from_list([";
    let first2 = true;
    body = fold(map4, body, (body2, key, value) => {
      if (!first2)
        body2 = body2 + ", ";
      first2 = false;
      return body2 + "#(" + this.inspect(key) + ", " + this.inspect(value) + ")";
    });
    return body + "])";
  }
  #customType(record) {
    const props = Object.keys(record).map((label) => {
      const value = this.inspect(record[label]);
      return isNaN(parseInt(label)) ? `${label}: ${value}` : value;
    }).join(", ");
    return props ? `${record.constructor.name}(${props})` : record.constructor.name;
  }
  #list(list2) {
    if (List$isEmpty(list2)) {
      return "[]";
    }
    let char_out = 'charlist.from_string("';
    let list_out = "[";
    let current = list2;
    while (List$isNonEmpty(current)) {
      let element = current.head;
      current = current.tail;
      if (list_out !== "[") {
        list_out += ", ";
      }
      list_out += this.inspect(element);
      if (char_out) {
        if (Number.isInteger(element) && element >= 32 && element <= 126) {
          char_out += String.fromCharCode(element);
        } else {
          char_out = null;
        }
      }
    }
    if (char_out) {
      return char_out + '")';
    } else {
      return list_out + "]";
    }
  }
  #string(str) {
    let new_str = '"';
    for (let i = 0;i < str.length; i++) {
      const char = str[i];
      switch (char) {
        case `
`:
          new_str += "\\n";
          break;
        case "\r":
          new_str += "\\r";
          break;
        case "\t":
          new_str += "\\t";
          break;
        case "\f":
          new_str += "\\f";
          break;
        case "\\":
          new_str += "\\\\";
          break;
        case '"':
          new_str += "\\\"";
          break;
        default:
          if (char < " " || char > "~" && char < " ") {
            new_str += "\\u{" + char.charCodeAt(0).toString(16).toUpperCase().padStart(4, "0") + "}";
          } else {
            new_str += char;
          }
      }
    }
    new_str += '"';
    return new_str;
  }
  #utfCodepoint(codepoint2) {
    return `//utfcodepoint(${String.fromCodePoint(codepoint2.value)})`;
  }
  #bit_array(bits2) {
    if (bits2.bitSize === 0) {
      return "<<>>";
    }
    let acc = "<<";
    for (let i = 0;i < bits2.byteSize - 1; i++) {
      acc += bits2.byteAt(i).toString();
      acc += ", ";
    }
    if (bits2.byteSize * 8 === bits2.bitSize) {
      acc += bits2.byteAt(bits2.byteSize - 1).toString();
    } else {
      const trailingBitsCount = bits2.bitSize % 8;
      acc += bits2.byteAt(bits2.byteSize - 1) >> 8 - trailingBitsCount;
      acc += `:size(${trailingBitsCount})`;
    }
    acc += ">>";
    return acc;
  }
}
function arrayToList(array) {
  let list2 = List$Empty();
  let i = array.length;
  while (i--) {
    list2 = List$NonEmpty(array[i], list2);
  }
  return list2;
}
function isList(data2) {
  return List$isEmpty(data2) || List$isNonEmpty(data2);
}
// build/dev/javascript/gleam_stdlib/gleam/result.mjs
function map4(result, fun) {
  if (result instanceof Ok) {
    let x = result[0];
    return new Ok(fun(x));
  } else {
    return result;
  }
}
function map_error(result, fun) {
  if (result instanceof Ok) {
    return result;
  } else {
    let error = result[0];
    return new Error(fun(error));
  }
}
function try$(result, fun) {
  if (result instanceof Ok) {
    let x = result[0];
    return fun(x);
  } else {
    return result;
  }
}
function unwrap(result, default$) {
  if (result instanceof Ok) {
    let v = result[0];
    return v;
  } else {
    return default$;
  }
}
function replace_error(result, error) {
  if (result instanceof Ok) {
    return result;
  } else {
    return new Error(error);
  }
}
// build/dev/javascript/gleam_stdlib/gleam/bool.mjs
function guard(requirement, consequence, alternative) {
  if (requirement) {
    return consequence;
  } else {
    return alternative();
  }
}

// build/dev/javascript/gleam_stdlib/gleam/function.mjs
function identity2(x) {
  return x;
}
// build/dev/javascript/houdini/houdini.ffi.mjs
function do_escape(string2) {
  return string2.replaceAll(/[><&"']/g, (replaced) => {
    switch (replaced) {
      case ">":
        return "&gt;";
      case "<":
        return "&lt;";
      case "'":
        return "&#39;";
      case "&":
        return "&amp;";
      case '"':
        return "&quot;";
      default:
        return replaced;
    }
  });
}

// build/dev/javascript/houdini/houdini/internal/escape_js.mjs
function escape(text) {
  return do_escape(text);
}

// build/dev/javascript/houdini/houdini.mjs
function escape2(string2) {
  return escape(string2);
}

// build/dev/javascript/lustre/lustre/internals/constants.mjs
var empty_list = /* @__PURE__ */ toList([]);
var error_nil = /* @__PURE__ */ new Error(undefined);

// build/dev/javascript/lustre/lustre/vdom/vattr.ffi.mjs
var GT = /* @__PURE__ */ Order$Gt();
var LT = /* @__PURE__ */ Order$Lt();
var EQ = /* @__PURE__ */ Order$Eq();
function compare2(a, b) {
  if (a.name === b.name) {
    return EQ;
  } else if (a.name < b.name) {
    return LT;
  } else {
    return GT;
  }
}

// build/dev/javascript/lustre/lustre/vdom/vattr.mjs
class Attribute extends CustomType {
  constructor(kind, name, value) {
    super();
    this.kind = kind;
    this.name = name;
    this.value = value;
  }
}
class Property extends CustomType {
  constructor(kind, name, value) {
    super();
    this.kind = kind;
    this.name = name;
    this.value = value;
  }
}
class Event2 extends CustomType {
  constructor(kind, name, handler, include, prevent_default, stop_propagation, debounce, throttle) {
    super();
    this.kind = kind;
    this.name = name;
    this.handler = handler;
    this.include = include;
    this.prevent_default = prevent_default;
    this.stop_propagation = stop_propagation;
    this.debounce = debounce;
    this.throttle = throttle;
  }
}
class Handler extends CustomType {
  constructor(prevent_default, stop_propagation, message) {
    super();
    this.prevent_default = prevent_default;
    this.stop_propagation = stop_propagation;
    this.message = message;
  }
}
class Never extends CustomType {
  constructor(kind) {
    super();
    this.kind = kind;
  }
}
var attribute_kind = 0;
var property_kind = 1;
var event_kind = 2;
var never_kind = 0;
var never = /* @__PURE__ */ new Never(never_kind);
var always_kind = 2;
function merge(loop$attributes, loop$merged) {
  while (true) {
    let attributes = loop$attributes;
    let merged = loop$merged;
    if (attributes instanceof Empty) {
      return merged;
    } else {
      let $ = attributes.head;
      if ($ instanceof Attribute) {
        let $1 = $.name;
        if ($1 === "") {
          let rest = attributes.tail;
          loop$attributes = rest;
          loop$merged = merged;
        } else if ($1 === "class") {
          let $2 = $.value;
          if ($2 === "") {
            let rest = attributes.tail;
            loop$attributes = rest;
            loop$merged = merged;
          } else {
            let $3 = attributes.tail;
            if ($3 instanceof Empty) {
              let attribute$1 = $;
              let rest = $3;
              loop$attributes = rest;
              loop$merged = prepend(attribute$1, merged);
            } else {
              let $4 = $3.head;
              if ($4 instanceof Attribute) {
                let $5 = $4.name;
                if ($5 === "class") {
                  let kind = $.kind;
                  let class1 = $2;
                  let rest = $3.tail;
                  let class2 = $4.value;
                  let value = class1 + " " + class2;
                  let attribute$1 = new Attribute(kind, "class", value);
                  loop$attributes = prepend(attribute$1, rest);
                  loop$merged = merged;
                } else {
                  let attribute$1 = $;
                  let rest = $3;
                  loop$attributes = rest;
                  loop$merged = prepend(attribute$1, merged);
                }
              } else {
                let attribute$1 = $;
                let rest = $3;
                loop$attributes = rest;
                loop$merged = prepend(attribute$1, merged);
              }
            }
          }
        } else if ($1 === "style") {
          let $2 = $.value;
          if ($2 === "") {
            let rest = attributes.tail;
            loop$attributes = rest;
            loop$merged = merged;
          } else {
            let $3 = attributes.tail;
            if ($3 instanceof Empty) {
              let attribute$1 = $;
              let rest = $3;
              loop$attributes = rest;
              loop$merged = prepend(attribute$1, merged);
            } else {
              let $4 = $3.head;
              if ($4 instanceof Attribute) {
                let $5 = $4.name;
                if ($5 === "style") {
                  let kind = $.kind;
                  let style1 = $2;
                  let rest = $3.tail;
                  let style2 = $4.value;
                  let value = style1 + ";" + style2;
                  let attribute$1 = new Attribute(kind, "style", value);
                  loop$attributes = prepend(attribute$1, rest);
                  loop$merged = merged;
                } else {
                  let attribute$1 = $;
                  let rest = $3;
                  loop$attributes = rest;
                  loop$merged = prepend(attribute$1, merged);
                }
              } else {
                let attribute$1 = $;
                let rest = $3;
                loop$attributes = rest;
                loop$merged = prepend(attribute$1, merged);
              }
            }
          }
        } else {
          let attribute$1 = $;
          let rest = attributes.tail;
          loop$attributes = rest;
          loop$merged = prepend(attribute$1, merged);
        }
      } else {
        let attribute$1 = $;
        let rest = attributes.tail;
        loop$attributes = rest;
        loop$merged = prepend(attribute$1, merged);
      }
    }
  }
}
function prepare(attributes) {
  if (attributes instanceof Empty) {
    return attributes;
  } else {
    let $ = attributes.tail;
    if ($ instanceof Empty) {
      return attributes;
    } else {
      let _pipe = attributes;
      let _pipe$1 = sort(_pipe, (a, b) => {
        return compare2(b, a);
      });
      return merge(_pipe$1, empty_list);
    }
  }
}
function attribute(name, value) {
  return new Attribute(attribute_kind, name, value);
}
function event(name, handler, include, prevent_default, stop_propagation, debounce, throttle) {
  return new Event2(event_kind, name, handler, include, prevent_default, stop_propagation, debounce, throttle);
}

// build/dev/javascript/lustre/lustre/attribute.mjs
function attribute2(name, value) {
  return attribute(name, value);
}
function class$(name) {
  return attribute2("class", name);
}
function none() {
  return class$("");
}
function id(value) {
  return attribute2("id", value);
}
function do_styles(loop$properties, loop$styles) {
  while (true) {
    let properties = loop$properties;
    let styles = loop$styles;
    if (properties instanceof Empty) {
      return styles;
    } else {
      let $ = properties.head[0];
      if ($ === "") {
        let rest = properties.tail;
        loop$properties = rest;
        loop$styles = styles;
      } else {
        let $1 = properties.head[1];
        if ($1 === "") {
          let rest = properties.tail;
          loop$properties = rest;
          loop$styles = styles;
        } else {
          let rest = properties.tail;
          let name$1 = $;
          let value$1 = $1;
          loop$properties = rest;
          loop$styles = styles + name$1 + ":" + value$1 + ";";
        }
      }
    }
  }
}
function styles(properties) {
  return attribute2("style", do_styles(properties, ""));
}
function autocomplete(value) {
  return attribute2("autocomplete", value);
}
function for$(id2) {
  return attribute2("for", id2);
}

// build/dev/javascript/lustre/lustre/effect.mjs
class Effect extends CustomType {
  constructor(synchronous, before_paint, after_paint) {
    super();
    this.synchronous = synchronous;
    this.before_paint = before_paint;
    this.after_paint = after_paint;
  }
}

class Actions extends CustomType {
  constructor(dispatch, emit, select, root, provide) {
    super();
    this.dispatch = dispatch;
    this.emit = emit;
    this.select = select;
    this.root = root;
    this.provide = provide;
  }
}
var empty = /* @__PURE__ */ new Effect(/* @__PURE__ */ toList([]), /* @__PURE__ */ toList([]), /* @__PURE__ */ toList([]));
function perform(effect, dispatch, emit, select, root, provide) {
  let actions = new Actions(dispatch, emit, select, root, provide);
  return each(effect.synchronous, (run2) => {
    return run2(actions);
  });
}
function none2() {
  return empty;
}
function from2(effect) {
  let task = (actions) => {
    let dispatch = actions.dispatch;
    return effect(dispatch);
  };
  return new Effect(toList([task]), empty.before_paint, empty.after_paint);
}
function after_paint(effect) {
  let task = (actions) => {
    let root = actions.root();
    let dispatch = actions.dispatch;
    return effect(dispatch, root);
  };
  return new Effect(empty.synchronous, empty.before_paint, toList([task]));
}
function batch(effects) {
  return fold2(effects, empty, (acc, eff) => {
    return new Effect(fold2(eff.synchronous, acc.synchronous, prepend2), fold2(eff.before_paint, acc.before_paint, prepend2), fold2(eff.after_paint, acc.after_paint, prepend2));
  });
}

// build/dev/javascript/lustre/lustre/internals/mutable_map.ffi.mjs
function empty2() {
  return null;
}
function get2(map5, key) {
  return map5?.get(key);
}
function get_or_compute(map5, key, compute) {
  return map5?.get(key) ?? compute();
}
function has_key(map5, key) {
  return map5 && map5.has(key);
}
function insert2(map5, key, value) {
  map5 ??= new Map;
  map5.set(key, value);
  return map5;
}
function remove(map5, key) {
  map5?.delete(key);
  return map5;
}

// build/dev/javascript/lustre/lustre/internals/ref.ffi.mjs
function sameValueZero(x, y) {
  if (typeof x === "number" && typeof y === "number") {
    return x === y || x !== x && y !== y;
  }
  return x === y;
}

// build/dev/javascript/lustre/lustre/internals/ref.mjs
function equal_lists(loop$xs, loop$ys) {
  while (true) {
    let xs = loop$xs;
    let ys = loop$ys;
    if (xs instanceof Empty) {
      if (ys instanceof Empty) {
        return true;
      } else {
        return false;
      }
    } else if (ys instanceof Empty) {
      return false;
    } else {
      let x = xs.head;
      let xs$1 = xs.tail;
      let y = ys.head;
      let ys$1 = ys.tail;
      let $ = sameValueZero(x, y);
      if ($) {
        loop$xs = xs$1;
        loop$ys = ys$1;
      } else {
        return $;
      }
    }
  }
}

// build/dev/javascript/lustre/lustre/vdom/vnode.mjs
class Fragment extends CustomType {
  constructor(kind, key, children, keyed_children) {
    super();
    this.kind = kind;
    this.key = key;
    this.children = children;
    this.keyed_children = keyed_children;
  }
}
class Element extends CustomType {
  constructor(kind, key, namespace, tag, attributes, children, keyed_children, self_closing, void$) {
    super();
    this.kind = kind;
    this.key = key;
    this.namespace = namespace;
    this.tag = tag;
    this.attributes = attributes;
    this.children = children;
    this.keyed_children = keyed_children;
    this.self_closing = self_closing;
    this.void = void$;
  }
}
class Text extends CustomType {
  constructor(kind, key, content) {
    super();
    this.kind = kind;
    this.key = key;
    this.content = content;
  }
}
class UnsafeInnerHtml extends CustomType {
  constructor(kind, key, namespace, tag, attributes, inner_html) {
    super();
    this.kind = kind;
    this.key = key;
    this.namespace = namespace;
    this.tag = tag;
    this.attributes = attributes;
    this.inner_html = inner_html;
  }
}
class Map2 extends CustomType {
  constructor(kind, key, mapper, child) {
    super();
    this.kind = kind;
    this.key = key;
    this.mapper = mapper;
    this.child = child;
  }
}
class Memo extends CustomType {
  constructor(kind, key, dependencies, view) {
    super();
    this.kind = kind;
    this.key = key;
    this.dependencies = dependencies;
    this.view = view;
  }
}
var fragment_kind = 0;
var element_kind = 1;
var text_kind = 2;
var unsafe_inner_html_kind = 3;
var map_kind = 4;
var memo_kind = 5;
function is_void_html_element(tag, namespace) {
  if (namespace === "") {
    if (tag === "area") {
      return true;
    } else if (tag === "base") {
      return true;
    } else if (tag === "br") {
      return true;
    } else if (tag === "col") {
      return true;
    } else if (tag === "embed") {
      return true;
    } else if (tag === "hr") {
      return true;
    } else if (tag === "img") {
      return true;
    } else if (tag === "input") {
      return true;
    } else if (tag === "link") {
      return true;
    } else if (tag === "meta") {
      return true;
    } else if (tag === "param") {
      return true;
    } else if (tag === "source") {
      return true;
    } else if (tag === "track") {
      return true;
    } else if (tag === "wbr") {
      return true;
    } else {
      return false;
    }
  } else {
    return false;
  }
}
function to_keyed(key, node) {
  if (node instanceof Fragment) {
    return new Fragment(node.kind, key, node.children, node.keyed_children);
  } else if (node instanceof Element) {
    return new Element(node.kind, key, node.namespace, node.tag, node.attributes, node.children, node.keyed_children, node.self_closing, node.void);
  } else if (node instanceof Text) {
    return new Text(node.kind, key, node.content);
  } else if (node instanceof UnsafeInnerHtml) {
    return new UnsafeInnerHtml(node.kind, key, node.namespace, node.tag, node.attributes, node.inner_html);
  } else if (node instanceof Map2) {
    let child = node.child;
    return new Map2(node.kind, key, node.mapper, to_keyed(key, child));
  } else {
    let view = node.view;
    return new Memo(node.kind, key, node.dependencies, () => {
      return to_keyed(key, view());
    });
  }
}
function fragment(key, children, keyed_children) {
  return new Fragment(fragment_kind, key, children, keyed_children);
}
function element(key, namespace, tag, attributes, children, keyed_children, self_closing, void$) {
  return new Element(element_kind, key, namespace, tag, prepare(attributes), children, keyed_children, self_closing, void$);
}
function text(key, content) {
  return new Text(text_kind, key, content);
}
function map5(element2, mapper) {
  if (element2 instanceof Map2) {
    let child_mapper = element2.mapper;
    return new Map2(map_kind, element2.key, (handler) => {
      return identity2(mapper)(child_mapper(handler));
    }, identity2(element2.child));
  } else {
    return new Map2(map_kind, element2.key, identity2(mapper), identity2(element2));
  }
}
function memo(key, dependencies, view) {
  return new Memo(memo_kind, key, dependencies, view);
}

// build/dev/javascript/lustre/lustre/element.mjs
function element2(tag, attributes, children) {
  return element("", "", tag, attributes, children, empty2(), false, is_void_html_element(tag, ""));
}
function text2(content) {
  return text("", content);
}
function none3() {
  return text("", "");
}
function memo2(dependencies, view) {
  return memo("", dependencies, view);
}
function ref(value) {
  return identity2(value);
}
function map6(element3, f) {
  return map5(element3, f);
}

// build/dev/javascript/lustre/lustre/element/html.mjs
function div(attrs, children) {
  return element2("div", attrs, children);
}
function span(attrs, children) {
  return element2("span", attrs, children);
}
function img(attrs) {
  return element2("img", attrs, empty_list);
}
function input(attrs) {
  return element2("input", attrs, empty_list);
}
function label(attrs, children) {
  return element2("label", attrs, children);
}

// build/dev/javascript/lustre/lustre/vdom/patch.mjs
class Patch extends CustomType {
  constructor(index3, removed, changes, children) {
    super();
    this.index = index3;
    this.removed = removed;
    this.changes = changes;
    this.children = children;
  }
}
class ReplaceText extends CustomType {
  constructor(kind, content) {
    super();
    this.kind = kind;
    this.content = content;
  }
}
class ReplaceInnerHtml extends CustomType {
  constructor(kind, inner_html) {
    super();
    this.kind = kind;
    this.inner_html = inner_html;
  }
}
class Update extends CustomType {
  constructor(kind, added, removed) {
    super();
    this.kind = kind;
    this.added = added;
    this.removed = removed;
  }
}
class Move extends CustomType {
  constructor(kind, key, before) {
    super();
    this.kind = kind;
    this.key = key;
    this.before = before;
  }
}
class Replace extends CustomType {
  constructor(kind, index3, with$) {
    super();
    this.kind = kind;
    this.index = index3;
    this.with = with$;
  }
}
class Remove extends CustomType {
  constructor(kind, index3) {
    super();
    this.kind = kind;
    this.index = index3;
  }
}
class Insert extends CustomType {
  constructor(kind, children, before) {
    super();
    this.kind = kind;
    this.children = children;
    this.before = before;
  }
}
var replace_text_kind = 0;
var replace_inner_html_kind = 1;
var update_kind = 2;
var move_kind = 3;
var remove_kind = 4;
var replace_kind = 5;
var insert_kind = 6;
function new$3(index3, removed, changes, children) {
  return new Patch(index3, removed, changes, children);
}
function replace_text(content) {
  return new ReplaceText(replace_text_kind, content);
}
function replace_inner_html(inner_html) {
  return new ReplaceInnerHtml(replace_inner_html_kind, inner_html);
}
function update(added, removed) {
  return new Update(update_kind, added, removed);
}
function move(key, before) {
  return new Move(move_kind, key, before);
}
function remove2(index3) {
  return new Remove(remove_kind, index3);
}
function replace2(index3, with$) {
  return new Replace(replace_kind, index3, with$);
}
function insert3(children, before) {
  return new Insert(insert_kind, children, before);
}

// build/dev/javascript/lustre/lustre/runtime/transport.mjs
class Mount extends CustomType {
  constructor(kind, open_shadow_root, will_adopt_styles, observed_attributes, observed_properties, requested_contexts, provided_contexts, vdom, memos) {
    super();
    this.kind = kind;
    this.open_shadow_root = open_shadow_root;
    this.will_adopt_styles = will_adopt_styles;
    this.observed_attributes = observed_attributes;
    this.observed_properties = observed_properties;
    this.requested_contexts = requested_contexts;
    this.provided_contexts = provided_contexts;
    this.vdom = vdom;
    this.memos = memos;
  }
}
class Reconcile extends CustomType {
  constructor(kind, patch, memos) {
    super();
    this.kind = kind;
    this.patch = patch;
    this.memos = memos;
  }
}
class Emit extends CustomType {
  constructor(kind, name, data2) {
    super();
    this.kind = kind;
    this.name = name;
    this.data = data2;
  }
}
class Provide extends CustomType {
  constructor(kind, key, value) {
    super();
    this.kind = kind;
    this.key = key;
    this.value = value;
  }
}
class Batch extends CustomType {
  constructor(kind, messages) {
    super();
    this.kind = kind;
    this.messages = messages;
  }
}
var ServerMessage$isBatch = (value) => value instanceof Batch;
class AttributeChanged extends CustomType {
  constructor(kind, name, value) {
    super();
    this.kind = kind;
    this.name = name;
    this.value = value;
  }
}
var ServerMessage$isAttributeChanged = (value) => value instanceof AttributeChanged;
class PropertyChanged extends CustomType {
  constructor(kind, name, value) {
    super();
    this.kind = kind;
    this.name = name;
    this.value = value;
  }
}
var ServerMessage$isPropertyChanged = (value) => value instanceof PropertyChanged;
class EventFired extends CustomType {
  constructor(kind, path, name, event2) {
    super();
    this.kind = kind;
    this.path = path;
    this.name = name;
    this.event = event2;
  }
}
var ServerMessage$isEventFired = (value) => value instanceof EventFired;
class ContextProvided extends CustomType {
  constructor(kind, key, value) {
    super();
    this.kind = kind;
    this.key = key;
    this.value = value;
  }
}
var ServerMessage$isContextProvided = (value) => value instanceof ContextProvided;
var mount_kind = 0;
var reconcile_kind = 1;
var emit_kind = 2;
var provide_kind = 3;
function mount(open_shadow_root, will_adopt_styles, observed_attributes, observed_properties, requested_contexts, provided_contexts, vdom, memos) {
  return new Mount(mount_kind, open_shadow_root, will_adopt_styles, observed_attributes, observed_properties, requested_contexts, provided_contexts, vdom, memos);
}
function reconcile(patch, memos) {
  return new Reconcile(reconcile_kind, patch, memos);
}
function emit(name, data2) {
  return new Emit(emit_kind, name, data2);
}
function provide(key, value) {
  return new Provide(provide_kind, key, value);
}

// build/dev/javascript/lustre/lustre/vdom/path.mjs
class Root extends CustomType {
}

class Key extends CustomType {
  constructor(key, parent) {
    super();
    this.key = key;
    this.parent = parent;
  }
}

class Index extends CustomType {
  constructor(index3, parent) {
    super();
    this.index = index3;
    this.parent = parent;
  }
}

class Subtree extends CustomType {
  constructor(parent) {
    super();
    this.parent = parent;
  }
}
var root = /* @__PURE__ */ new Root;
var separator_element = "\t";
var separator_subtree = "\r";
var separator_event = `
`;
function do_matches(loop$path, loop$candidates) {
  while (true) {
    let path = loop$path;
    let candidates = loop$candidates;
    if (candidates instanceof Empty) {
      return false;
    } else {
      let candidate = candidates.head;
      let rest = candidates.tail;
      let $ = starts_with(path, candidate);
      if ($) {
        return $;
      } else {
        loop$path = path;
        loop$candidates = rest;
      }
    }
  }
}
function add2(parent, index3, key) {
  if (key === "") {
    return new Index(index3, parent);
  } else {
    return new Key(key, parent);
  }
}
function subtree(path) {
  return new Subtree(path);
}
function finish_to_string(acc) {
  if (acc instanceof Empty) {
    return "";
  } else {
    let segments = acc.tail;
    return concat2(segments);
  }
}
function split_subtree_path(path) {
  return split2(path, separator_subtree);
}
function do_to_string(loop$full, loop$path, loop$acc) {
  while (true) {
    let full = loop$full;
    let path = loop$path;
    let acc = loop$acc;
    if (path instanceof Root) {
      return finish_to_string(acc);
    } else if (path instanceof Key) {
      let key = path.key;
      let parent = path.parent;
      loop$full = full;
      loop$path = parent;
      loop$acc = prepend(separator_element, prepend(key, acc));
    } else if (path instanceof Index) {
      let index3 = path.index;
      let parent = path.parent;
      let acc$1 = prepend(separator_element, prepend(to_string(index3), acc));
      loop$full = full;
      loop$path = parent;
      loop$acc = acc$1;
    } else if (!full) {
      return finish_to_string(acc);
    } else {
      let parent = path.parent;
      if (acc instanceof Empty) {
        loop$full = full;
        loop$path = parent;
        loop$acc = acc;
      } else {
        let acc$1 = acc.tail;
        loop$full = full;
        loop$path = parent;
        loop$acc = prepend(separator_subtree, acc$1);
      }
    }
  }
}
function child(path) {
  return do_to_string(false, path, empty_list);
}
function to_string3(path) {
  return do_to_string(true, path, empty_list);
}
function matches(path, candidates) {
  if (candidates instanceof Empty) {
    return false;
  } else {
    return do_matches(to_string3(path), candidates);
  }
}
function event2(path, event3) {
  return do_to_string(false, path, prepend(separator_event, prepend(event3, empty_list)));
}

// build/dev/javascript/lustre/lustre/vdom/cache.mjs
class Cache extends CustomType {
  constructor(events, vdoms, old_vdoms, dispatched_paths, next_dispatched_paths) {
    super();
    this.events = events;
    this.vdoms = vdoms;
    this.old_vdoms = old_vdoms;
    this.dispatched_paths = dispatched_paths;
    this.next_dispatched_paths = next_dispatched_paths;
  }
}

class Events extends CustomType {
  constructor(handlers, children) {
    super();
    this.handlers = handlers;
    this.children = children;
  }
}

class Child extends CustomType {
  constructor(mapper, events) {
    super();
    this.mapper = mapper;
    this.events = events;
  }
}

class AddedChildren extends CustomType {
  constructor(handlers, children, vdoms) {
    super();
    this.handlers = handlers;
    this.children = children;
    this.vdoms = vdoms;
  }
}

class DecodedEvent extends CustomType {
  constructor(path, handler) {
    super();
    this.path = path;
    this.handler = handler;
  }
}

class DispatchedEvent extends CustomType {
  constructor(path) {
    super();
    this.path = path;
  }
}
function compose_mapper(mapper, child_mapper) {
  return (msg) => {
    return mapper(child_mapper(msg));
  };
}
function new_events() {
  return new Events(empty2(), empty2());
}
function new$4() {
  return new Cache(new_events(), empty2(), empty2(), empty_list, empty_list);
}
function tick(cache) {
  return new Cache(cache.events, empty2(), cache.vdoms, cache.next_dispatched_paths, empty_list);
}
function events(cache) {
  return cache.events;
}
function update_events(cache, events2) {
  return new Cache(events2, cache.vdoms, cache.old_vdoms, cache.dispatched_paths, cache.next_dispatched_paths);
}
function memos(cache) {
  return cache.vdoms;
}
function get_old_memo(cache, old, new$5) {
  return get_or_compute(cache.old_vdoms, old, new$5);
}
function keep_memo(cache, old, new$5) {
  let node = get_or_compute(cache.old_vdoms, old, new$5);
  let vdoms = insert2(cache.vdoms, new$5, node);
  return new Cache(cache.events, vdoms, cache.old_vdoms, cache.dispatched_paths, cache.next_dispatched_paths);
}
function add_memo(cache, new$5, node) {
  let vdoms = insert2(cache.vdoms, new$5, node);
  return new Cache(cache.events, vdoms, cache.old_vdoms, cache.dispatched_paths, cache.next_dispatched_paths);
}
function get_subtree(events2, path, old_mapper) {
  let child2 = get_or_compute(events2.children, path, () => {
    return new Child(old_mapper, new_events());
  });
  return child2.events;
}
function update_subtree(parent, path, mapper, events2) {
  let new_child = new Child(mapper, events2);
  let children = insert2(parent.children, path, new_child);
  return new Events(parent.handlers, children);
}
function do_add_event(handlers, path, name, handler) {
  return insert2(handlers, event2(path, name), handler);
}
function add_event(events2, path, name, handler) {
  let handlers = do_add_event(events2.handlers, path, name, handler);
  return new Events(handlers, events2.children);
}
function do_remove_event(handlers, path, name) {
  return remove(handlers, event2(path, name));
}
function remove_event(events2, path, name) {
  let handlers = do_remove_event(events2.handlers, path, name);
  return new Events(handlers, events2.children);
}
function add_attributes(handlers, path, attributes) {
  return fold2(attributes, handlers, (events2, attribute3) => {
    if (attribute3 instanceof Event2) {
      let name = attribute3.name;
      let handler = attribute3.handler;
      return do_add_event(events2, path, name, handler);
    } else {
      return events2;
    }
  });
}
function do_add_children(loop$handlers, loop$children, loop$vdoms, loop$parent, loop$child_index, loop$nodes) {
  while (true) {
    let handlers = loop$handlers;
    let children = loop$children;
    let vdoms = loop$vdoms;
    let parent = loop$parent;
    let child_index = loop$child_index;
    let nodes = loop$nodes;
    let next = child_index + 1;
    if (nodes instanceof Empty) {
      return new AddedChildren(handlers, children, vdoms);
    } else {
      let $ = nodes.head;
      if ($ instanceof Fragment) {
        let rest = nodes.tail;
        let key = $.key;
        let nodes$1 = $.children;
        let path = add2(parent, child_index, key);
        let $1 = do_add_children(handlers, children, vdoms, path, 0, nodes$1);
        let handlers$1;
        let children$1;
        let vdoms$1;
        handlers$1 = $1.handlers;
        children$1 = $1.children;
        vdoms$1 = $1.vdoms;
        loop$handlers = handlers$1;
        loop$children = children$1;
        loop$vdoms = vdoms$1;
        loop$parent = parent;
        loop$child_index = next;
        loop$nodes = rest;
      } else if ($ instanceof Element) {
        let rest = nodes.tail;
        let key = $.key;
        let attributes = $.attributes;
        let nodes$1 = $.children;
        let path = add2(parent, child_index, key);
        let handlers$1 = add_attributes(handlers, path, attributes);
        let $1 = do_add_children(handlers$1, children, vdoms, path, 0, nodes$1);
        let handlers$2;
        let children$1;
        let vdoms$1;
        handlers$2 = $1.handlers;
        children$1 = $1.children;
        vdoms$1 = $1.vdoms;
        loop$handlers = handlers$2;
        loop$children = children$1;
        loop$vdoms = vdoms$1;
        loop$parent = parent;
        loop$child_index = next;
        loop$nodes = rest;
      } else if ($ instanceof Text) {
        let rest = nodes.tail;
        loop$handlers = handlers;
        loop$children = children;
        loop$vdoms = vdoms;
        loop$parent = parent;
        loop$child_index = next;
        loop$nodes = rest;
      } else if ($ instanceof UnsafeInnerHtml) {
        let rest = nodes.tail;
        let key = $.key;
        let attributes = $.attributes;
        let path = add2(parent, child_index, key);
        let handlers$1 = add_attributes(handlers, path, attributes);
        loop$handlers = handlers$1;
        loop$children = children;
        loop$vdoms = vdoms;
        loop$parent = parent;
        loop$child_index = next;
        loop$nodes = rest;
      } else if ($ instanceof Map2) {
        let rest = nodes.tail;
        let key = $.key;
        let mapper = $.mapper;
        let child2 = $.child;
        let path = add2(parent, child_index, key);
        let added = do_add_children(empty2(), empty2(), vdoms, subtree(path), 0, prepend(child2, empty_list));
        let vdoms$1 = added.vdoms;
        let child_events = new Events(added.handlers, added.children);
        let child$1 = new Child(mapper, child_events);
        let children$1 = insert2(children, child(path), child$1);
        loop$handlers = handlers;
        loop$children = children$1;
        loop$vdoms = vdoms$1;
        loop$parent = parent;
        loop$child_index = next;
        loop$nodes = rest;
      } else {
        let rest = nodes.tail;
        let view = $.view;
        let child_node = view();
        let vdoms$1 = insert2(vdoms, view, child_node);
        let next$1 = child_index;
        let rest$1 = prepend(child_node, rest);
        loop$handlers = handlers;
        loop$children = children;
        loop$vdoms = vdoms$1;
        loop$parent = parent;
        loop$child_index = next$1;
        loop$nodes = rest$1;
      }
    }
  }
}
function add_children(cache, events2, path, child_index, nodes) {
  let vdoms = cache.vdoms;
  let handlers;
  let children;
  handlers = events2.handlers;
  children = events2.children;
  let $ = do_add_children(handlers, children, vdoms, path, child_index, nodes);
  let handlers$1;
  let children$1;
  let vdoms$1;
  handlers$1 = $.handlers;
  children$1 = $.children;
  vdoms$1 = $.vdoms;
  return [
    new Cache(cache.events, vdoms$1, cache.old_vdoms, cache.dispatched_paths, cache.next_dispatched_paths),
    new Events(handlers$1, children$1)
  ];
}
function add_child(cache, events2, parent, index3, child2) {
  let children = prepend(child2, empty_list);
  return add_children(cache, events2, parent, index3, children);
}
function from_node(root2) {
  let cache = new$4();
  let $ = add_child(cache, cache.events, root, 0, root2);
  let cache$1;
  let events$1;
  cache$1 = $[0];
  events$1 = $[1];
  return new Cache(events$1, cache$1.vdoms, cache$1.old_vdoms, cache$1.dispatched_paths, cache$1.next_dispatched_paths);
}
function remove_attributes(handlers, path, attributes) {
  return fold2(attributes, handlers, (events2, attribute3) => {
    if (attribute3 instanceof Event2) {
      let name = attribute3.name;
      return do_remove_event(events2, path, name);
    } else {
      return events2;
    }
  });
}
function do_remove_children(loop$handlers, loop$children, loop$vdoms, loop$parent, loop$index, loop$nodes) {
  while (true) {
    let handlers = loop$handlers;
    let children = loop$children;
    let vdoms = loop$vdoms;
    let parent = loop$parent;
    let index3 = loop$index;
    let nodes = loop$nodes;
    let next = index3 + 1;
    if (nodes instanceof Empty) {
      return new Events(handlers, children);
    } else {
      let $ = nodes.head;
      if ($ instanceof Fragment) {
        let rest = nodes.tail;
        let key = $.key;
        let nodes$1 = $.children;
        let path = add2(parent, index3, key);
        let $1 = do_remove_children(handlers, children, vdoms, path, 0, nodes$1);
        let handlers$1;
        let children$1;
        handlers$1 = $1.handlers;
        children$1 = $1.children;
        loop$handlers = handlers$1;
        loop$children = children$1;
        loop$vdoms = vdoms;
        loop$parent = parent;
        loop$index = next;
        loop$nodes = rest;
      } else if ($ instanceof Element) {
        let rest = nodes.tail;
        let key = $.key;
        let attributes = $.attributes;
        let nodes$1 = $.children;
        let path = add2(parent, index3, key);
        let handlers$1 = remove_attributes(handlers, path, attributes);
        let $1 = do_remove_children(handlers$1, children, vdoms, path, 0, nodes$1);
        let handlers$2;
        let children$1;
        handlers$2 = $1.handlers;
        children$1 = $1.children;
        loop$handlers = handlers$2;
        loop$children = children$1;
        loop$vdoms = vdoms;
        loop$parent = parent;
        loop$index = next;
        loop$nodes = rest;
      } else if ($ instanceof Text) {
        let rest = nodes.tail;
        loop$handlers = handlers;
        loop$children = children;
        loop$vdoms = vdoms;
        loop$parent = parent;
        loop$index = next;
        loop$nodes = rest;
      } else if ($ instanceof UnsafeInnerHtml) {
        let rest = nodes.tail;
        let key = $.key;
        let attributes = $.attributes;
        let path = add2(parent, index3, key);
        let handlers$1 = remove_attributes(handlers, path, attributes);
        loop$handlers = handlers$1;
        loop$children = children;
        loop$vdoms = vdoms;
        loop$parent = parent;
        loop$index = next;
        loop$nodes = rest;
      } else if ($ instanceof Map2) {
        let rest = nodes.tail;
        let key = $.key;
        let path = add2(parent, index3, key);
        let children$1 = remove(children, child(path));
        loop$handlers = handlers;
        loop$children = children$1;
        loop$vdoms = vdoms;
        loop$parent = parent;
        loop$index = next;
        loop$nodes = rest;
      } else {
        let rest = nodes.tail;
        let view = $.view;
        let $1 = has_key(vdoms, view);
        if ($1) {
          let child2 = get2(vdoms, view);
          let nodes$1 = prepend(child2, rest);
          loop$handlers = handlers;
          loop$children = children;
          loop$vdoms = vdoms;
          loop$parent = parent;
          loop$index = index3;
          loop$nodes = nodes$1;
        } else {
          loop$handlers = handlers;
          loop$children = children;
          loop$vdoms = vdoms;
          loop$parent = parent;
          loop$index = next;
          loop$nodes = rest;
        }
      }
    }
  }
}
function remove_child(cache, events2, parent, child_index, child2) {
  return do_remove_children(events2.handlers, events2.children, cache.old_vdoms, parent, child_index, prepend(child2, empty_list));
}
function replace_child(cache, events2, parent, child_index, prev, next) {
  let events$1 = remove_child(cache, events2, parent, child_index, prev);
  return add_child(cache, events$1, parent, child_index, next);
}
function dispatch(cache, event3) {
  let next_dispatched_paths = prepend(event3.path, cache.next_dispatched_paths);
  let cache$1 = new Cache(cache.events, cache.vdoms, cache.old_vdoms, cache.dispatched_paths, next_dispatched_paths);
  if (event3 instanceof DecodedEvent) {
    let handler = event3.handler;
    return [cache$1, new Ok(handler)];
  } else {
    return [cache$1, error_nil];
  }
}
function has_dispatched_events(cache, path) {
  return matches(path, cache.dispatched_paths);
}
function get_handler(loop$events, loop$path, loop$mapper) {
  while (true) {
    let events2 = loop$events;
    let path = loop$path;
    let mapper = loop$mapper;
    if (path instanceof Empty) {
      return error_nil;
    } else {
      let $ = path.tail;
      if ($ instanceof Empty) {
        let key = path.head;
        let $1 = has_key(events2.handlers, key);
        if ($1) {
          let handler = get2(events2.handlers, key);
          return new Ok(map3(handler, (handler2) => {
            return new Handler(handler2.prevent_default, handler2.stop_propagation, identity2(mapper)(handler2.message));
          }));
        } else {
          return error_nil;
        }
      } else {
        let key = path.head;
        let path$1 = $;
        let $1 = has_key(events2.children, key);
        if ($1) {
          let child2 = get2(events2.children, key);
          let mapper$1 = compose_mapper(mapper, child2.mapper);
          loop$events = child2.events;
          loop$path = path$1;
          loop$mapper = mapper$1;
        } else {
          return error_nil;
        }
      }
    }
  }
}
function decode2(cache, path, name, event3) {
  let parts = split_subtree_path(path + separator_event + name);
  let $ = get_handler(cache.events, parts, identity2);
  if ($ instanceof Ok) {
    let handler = $[0];
    let $1 = run(event3, handler);
    if ($1 instanceof Ok) {
      let handler$1 = $1[0];
      return new DecodedEvent(path, handler$1);
    } else {
      return new DispatchedEvent(path);
    }
  } else {
    return new DispatchedEvent(path);
  }
}
function handle(cache, path, name, event3) {
  let _pipe = decode2(cache, path, name, event3);
  return ((_capture) => {
    return dispatch(cache, _capture);
  })(_pipe);
}

// build/dev/javascript/lustre/lustre/runtime/server/runtime.mjs
class ClientDispatchedMessage extends CustomType {
  constructor(message) {
    super();
    this.message = message;
  }
}
var Message$isClientDispatchedMessage = (value) => value instanceof ClientDispatchedMessage;
class ClientRegisteredCallback extends CustomType {
  constructor(callback) {
    super();
    this.callback = callback;
  }
}
var Message$isClientRegisteredCallback = (value) => value instanceof ClientRegisteredCallback;
class ClientDeregisteredCallback extends CustomType {
  constructor(callback) {
    super();
    this.callback = callback;
  }
}
var Message$isClientDeregisteredCallback = (value) => value instanceof ClientDeregisteredCallback;
class EffectDispatchedMessage extends CustomType {
  constructor(message) {
    super();
    this.message = message;
  }
}
var Message$EffectDispatchedMessage = (message) => new EffectDispatchedMessage(message);
var Message$isEffectDispatchedMessage = (value) => value instanceof EffectDispatchedMessage;
class EffectEmitEvent extends CustomType {
  constructor(name, data2) {
    super();
    this.name = name;
    this.data = data2;
  }
}
var Message$EffectEmitEvent = (name, data2) => new EffectEmitEvent(name, data2);
var Message$isEffectEmitEvent = (value) => value instanceof EffectEmitEvent;
class EffectProvidedValue extends CustomType {
  constructor(key, value) {
    super();
    this.key = key;
    this.value = value;
  }
}
var Message$EffectProvidedValue = (key, value) => new EffectProvidedValue(key, value);
var Message$isEffectProvidedValue = (value) => value instanceof EffectProvidedValue;
class SystemRequestedShutdown extends CustomType {
}
var Message$isSystemRequestedShutdown = (value) => value instanceof SystemRequestedShutdown;

// build/dev/javascript/lustre/lustre/runtime/app.mjs
class App extends CustomType {
  constructor(name, init, update2, view, config2) {
    super();
    this.name = name;
    this.init = init;
    this.update = update2;
    this.view = view;
    this.config = config2;
  }
}
class Config2 extends CustomType {
  constructor(open_shadow_root, adopt_styles, delegates_focus, attributes, properties, contexts, is_form_associated, on_form_autofill, on_form_reset, on_form_restore, on_connect, on_adopt, on_disconnect) {
    super();
    this.open_shadow_root = open_shadow_root;
    this.adopt_styles = adopt_styles;
    this.delegates_focus = delegates_focus;
    this.attributes = attributes;
    this.properties = properties;
    this.contexts = contexts;
    this.is_form_associated = is_form_associated;
    this.on_form_autofill = on_form_autofill;
    this.on_form_reset = on_form_reset;
    this.on_form_restore = on_form_restore;
    this.on_connect = on_connect;
    this.on_adopt = on_adopt;
    this.on_disconnect = on_disconnect;
  }
}
var default_config = /* @__PURE__ */ new Config2(true, true, false, empty_list, empty_list, empty_list, false, /* @__PURE__ */ new None, /* @__PURE__ */ new None, /* @__PURE__ */ new None, /* @__PURE__ */ new None, /* @__PURE__ */ new None, /* @__PURE__ */ new None);

// build/dev/javascript/lustre/lustre/internals/equals.ffi.mjs
var isEqual2 = (a, b) => {
  if (a === b) {
    return true;
  }
  if (a == null || b == null) {
    return false;
  }
  const type = typeof a;
  if (type !== typeof b) {
    return false;
  }
  if (type !== "object") {
    return false;
  }
  const ctor = a.constructor;
  if (ctor !== b.constructor) {
    return false;
  }
  if (Array.isArray(a)) {
    return areArraysEqual(a, b);
  }
  return areObjectsEqual(a, b);
};
var areArraysEqual = (a, b) => {
  let index3 = a.length;
  if (index3 !== b.length) {
    return false;
  }
  while (index3--) {
    if (!isEqual2(a[index3], b[index3])) {
      return false;
    }
  }
  return true;
};
var areObjectsEqual = (a, b) => {
  const properties = Object.keys(a);
  let index3 = properties.length;
  if (Object.keys(b).length !== index3) {
    return false;
  }
  while (index3--) {
    const property3 = properties[index3];
    if (!Object.hasOwn(b, property3)) {
      return false;
    }
    if (!isEqual2(a[property3], b[property3])) {
      return false;
    }
  }
  return true;
};

// build/dev/javascript/lustre/lustre/vdom/diff.mjs
class Diff extends CustomType {
  constructor(patch, cache) {
    super();
    this.patch = patch;
    this.cache = cache;
  }
}
class PartialDiff extends CustomType {
  constructor(patch, cache, events2) {
    super();
    this.patch = patch;
    this.cache = cache;
    this.events = events2;
  }
}

class AttributeChange extends CustomType {
  constructor(added, removed, events2) {
    super();
    this.added = added;
    this.removed = removed;
    this.events = events2;
  }
}
function is_controlled(cache, namespace, tag, path) {
  if (tag === "input" && namespace === "") {
    return has_dispatched_events(cache, path);
  } else if (tag === "select" && namespace === "") {
    return has_dispatched_events(cache, path);
  } else if (tag === "textarea" && namespace === "") {
    return has_dispatched_events(cache, path);
  } else {
    return false;
  }
}
function diff_attributes(loop$controlled, loop$path, loop$events, loop$old, loop$new, loop$added, loop$removed) {
  while (true) {
    let controlled = loop$controlled;
    let path = loop$path;
    let events2 = loop$events;
    let old = loop$old;
    let new$5 = loop$new;
    let added = loop$added;
    let removed = loop$removed;
    if (old instanceof Empty) {
      if (new$5 instanceof Empty) {
        return new AttributeChange(added, removed, events2);
      } else {
        let $ = new$5.head;
        if ($ instanceof Event2) {
          let next = $;
          let new$1 = new$5.tail;
          let name = $.name;
          let handler = $.handler;
          let events$1 = add_event(events2, path, name, handler);
          let added$1 = prepend(next, added);
          loop$controlled = controlled;
          loop$path = path;
          loop$events = events$1;
          loop$old = old;
          loop$new = new$1;
          loop$added = added$1;
          loop$removed = removed;
        } else {
          let next = $;
          let new$1 = new$5.tail;
          let added$1 = prepend(next, added);
          loop$controlled = controlled;
          loop$path = path;
          loop$events = events2;
          loop$old = old;
          loop$new = new$1;
          loop$added = added$1;
          loop$removed = removed;
        }
      }
    } else if (new$5 instanceof Empty) {
      let $ = old.head;
      if ($ instanceof Event2) {
        let prev = $;
        let old$1 = old.tail;
        let name = $.name;
        let events$1 = remove_event(events2, path, name);
        let removed$1 = prepend(prev, removed);
        loop$controlled = controlled;
        loop$path = path;
        loop$events = events$1;
        loop$old = old$1;
        loop$new = new$5;
        loop$added = added;
        loop$removed = removed$1;
      } else {
        let prev = $;
        let old$1 = old.tail;
        let removed$1 = prepend(prev, removed);
        loop$controlled = controlled;
        loop$path = path;
        loop$events = events2;
        loop$old = old$1;
        loop$new = new$5;
        loop$added = added;
        loop$removed = removed$1;
      }
    } else {
      let prev = old.head;
      let remaining_old = old.tail;
      let next = new$5.head;
      let remaining_new = new$5.tail;
      let $ = compare2(prev, next);
      if ($ instanceof Lt) {
        if (prev instanceof Event2) {
          let name = prev.name;
          loop$controlled = controlled;
          loop$path = path;
          loop$events = remove_event(events2, path, name);
          loop$old = remaining_old;
          loop$new = new$5;
          loop$added = added;
          loop$removed = prepend(prev, removed);
        } else {
          loop$controlled = controlled;
          loop$path = path;
          loop$events = events2;
          loop$old = remaining_old;
          loop$new = new$5;
          loop$added = added;
          loop$removed = prepend(prev, removed);
        }
      } else if ($ instanceof Eq) {
        if (prev instanceof Attribute) {
          if (next instanceof Attribute) {
            let _block;
            let $1 = next.name;
            if ($1 === "value") {
              _block = controlled || prev.value !== next.value;
            } else if ($1 === "checked") {
              _block = controlled || prev.value !== next.value;
            } else if ($1 === "selected") {
              _block = controlled || prev.value !== next.value;
            } else {
              _block = prev.value !== next.value;
            }
            let has_changes = _block;
            let _block$1;
            if (has_changes) {
              _block$1 = prepend(next, added);
            } else {
              _block$1 = added;
            }
            let added$1 = _block$1;
            loop$controlled = controlled;
            loop$path = path;
            loop$events = events2;
            loop$old = remaining_old;
            loop$new = remaining_new;
            loop$added = added$1;
            loop$removed = removed;
          } else if (next instanceof Event2) {
            let name = next.name;
            let handler = next.handler;
            loop$controlled = controlled;
            loop$path = path;
            loop$events = add_event(events2, path, name, handler);
            loop$old = remaining_old;
            loop$new = remaining_new;
            loop$added = prepend(next, added);
            loop$removed = prepend(prev, removed);
          } else {
            loop$controlled = controlled;
            loop$path = path;
            loop$events = events2;
            loop$old = remaining_old;
            loop$new = remaining_new;
            loop$added = prepend(next, added);
            loop$removed = prepend(prev, removed);
          }
        } else if (prev instanceof Property) {
          if (next instanceof Property) {
            let _block;
            let $1 = next.name;
            if ($1 === "scrollLeft") {
              _block = true;
            } else if ($1 === "scrollRight") {
              _block = true;
            } else if ($1 === "value") {
              _block = controlled || !isEqual2(prev.value, next.value);
            } else if ($1 === "checked") {
              _block = controlled || !isEqual2(prev.value, next.value);
            } else if ($1 === "selected") {
              _block = controlled || !isEqual2(prev.value, next.value);
            } else {
              _block = !isEqual2(prev.value, next.value);
            }
            let has_changes = _block;
            let _block$1;
            if (has_changes) {
              _block$1 = prepend(next, added);
            } else {
              _block$1 = added;
            }
            let added$1 = _block$1;
            loop$controlled = controlled;
            loop$path = path;
            loop$events = events2;
            loop$old = remaining_old;
            loop$new = remaining_new;
            loop$added = added$1;
            loop$removed = removed;
          } else if (next instanceof Event2) {
            let name = next.name;
            let handler = next.handler;
            loop$controlled = controlled;
            loop$path = path;
            loop$events = add_event(events2, path, name, handler);
            loop$old = remaining_old;
            loop$new = remaining_new;
            loop$added = prepend(next, added);
            loop$removed = prepend(prev, removed);
          } else {
            loop$controlled = controlled;
            loop$path = path;
            loop$events = events2;
            loop$old = remaining_old;
            loop$new = remaining_new;
            loop$added = prepend(next, added);
            loop$removed = prepend(prev, removed);
          }
        } else if (next instanceof Event2) {
          let name = next.name;
          let handler = next.handler;
          let has_changes = prev.prevent_default.kind !== next.prevent_default.kind || prev.stop_propagation.kind !== next.stop_propagation.kind || prev.debounce !== next.debounce || prev.throttle !== next.throttle;
          let _block;
          if (has_changes) {
            _block = prepend(next, added);
          } else {
            _block = added;
          }
          let added$1 = _block;
          loop$controlled = controlled;
          loop$path = path;
          loop$events = add_event(events2, path, name, handler);
          loop$old = remaining_old;
          loop$new = remaining_new;
          loop$added = added$1;
          loop$removed = removed;
        } else {
          let name = prev.name;
          loop$controlled = controlled;
          loop$path = path;
          loop$events = remove_event(events2, path, name);
          loop$old = remaining_old;
          loop$new = remaining_new;
          loop$added = prepend(next, added);
          loop$removed = prepend(prev, removed);
        }
      } else if (next instanceof Event2) {
        let name = next.name;
        let handler = next.handler;
        loop$controlled = controlled;
        loop$path = path;
        loop$events = add_event(events2, path, name, handler);
        loop$old = old;
        loop$new = remaining_new;
        loop$added = prepend(next, added);
        loop$removed = removed;
      } else {
        loop$controlled = controlled;
        loop$path = path;
        loop$events = events2;
        loop$old = old;
        loop$new = remaining_new;
        loop$added = prepend(next, added);
        loop$removed = removed;
      }
    }
  }
}
function do_diff(loop$old, loop$old_keyed, loop$new, loop$new_keyed, loop$moved, loop$moved_offset, loop$removed, loop$node_index, loop$patch_index, loop$changes, loop$children, loop$path, loop$cache, loop$events) {
  while (true) {
    let old = loop$old;
    let old_keyed = loop$old_keyed;
    let new$5 = loop$new;
    let new_keyed = loop$new_keyed;
    let moved = loop$moved;
    let moved_offset = loop$moved_offset;
    let removed = loop$removed;
    let node_index = loop$node_index;
    let patch_index = loop$patch_index;
    let changes = loop$changes;
    let children = loop$children;
    let path = loop$path;
    let cache = loop$cache;
    let events2 = loop$events;
    if (old instanceof Empty) {
      if (new$5 instanceof Empty) {
        let patch = new Patch(patch_index, removed, changes, children);
        return new PartialDiff(patch, cache, events2);
      } else {
        let $ = add_children(cache, events2, path, node_index, new$5);
        let cache$1;
        let events$1;
        cache$1 = $[0];
        events$1 = $[1];
        let insert4 = insert3(new$5, node_index - moved_offset);
        let changes$1 = prepend(insert4, changes);
        let patch = new Patch(patch_index, removed, changes$1, children);
        return new PartialDiff(patch, cache$1, events$1);
      }
    } else if (new$5 instanceof Empty) {
      let prev = old.head;
      let old$1 = old.tail;
      let _block;
      let $ = prev.key === "" || !has_key(moved, prev.key);
      if ($) {
        _block = removed + 1;
      } else {
        _block = removed;
      }
      let removed$1 = _block;
      let events$1 = remove_child(cache, events2, path, node_index, prev);
      loop$old = old$1;
      loop$old_keyed = old_keyed;
      loop$new = new$5;
      loop$new_keyed = new_keyed;
      loop$moved = moved;
      loop$moved_offset = moved_offset;
      loop$removed = removed$1;
      loop$node_index = node_index;
      loop$patch_index = patch_index;
      loop$changes = changes;
      loop$children = children;
      loop$path = path;
      loop$cache = cache;
      loop$events = events$1;
    } else {
      let prev = old.head;
      let next = new$5.head;
      if (prev.key !== next.key) {
        let old_remaining = old.tail;
        let new_remaining = new$5.tail;
        let next_did_exist = has_key(old_keyed, next.key);
        let prev_does_exist = has_key(new_keyed, prev.key);
        if (prev_does_exist) {
          if (next_did_exist) {
            let $ = has_key(moved, prev.key);
            if ($) {
              loop$old = old_remaining;
              loop$old_keyed = old_keyed;
              loop$new = new$5;
              loop$new_keyed = new_keyed;
              loop$moved = moved;
              loop$moved_offset = moved_offset - 1;
              loop$removed = removed;
              loop$node_index = node_index;
              loop$patch_index = patch_index;
              loop$changes = changes;
              loop$children = children;
              loop$path = path;
              loop$cache = cache;
              loop$events = events2;
            } else {
              let match = get2(old_keyed, next.key);
              let before = node_index - moved_offset;
              let changes$1 = prepend(move(next.key, before), changes);
              let moved$1 = insert2(moved, next.key, undefined);
              loop$old = prepend(match, old);
              loop$old_keyed = old_keyed;
              loop$new = new$5;
              loop$new_keyed = new_keyed;
              loop$moved = moved$1;
              loop$moved_offset = moved_offset + 1;
              loop$removed = removed;
              loop$node_index = node_index;
              loop$patch_index = patch_index;
              loop$changes = changes$1;
              loop$children = children;
              loop$path = path;
              loop$cache = cache;
              loop$events = events2;
            }
          } else {
            let before = node_index - moved_offset;
            let $ = add_child(cache, events2, path, node_index, next);
            let cache$1;
            let events$1;
            cache$1 = $[0];
            events$1 = $[1];
            let insert4 = insert3(toList([next]), before);
            let changes$1 = prepend(insert4, changes);
            loop$old = old;
            loop$old_keyed = old_keyed;
            loop$new = new_remaining;
            loop$new_keyed = new_keyed;
            loop$moved = moved;
            loop$moved_offset = moved_offset + 1;
            loop$removed = removed;
            loop$node_index = node_index + 1;
            loop$patch_index = patch_index;
            loop$changes = changes$1;
            loop$children = children;
            loop$path = path;
            loop$cache = cache$1;
            loop$events = events$1;
          }
        } else if (next_did_exist) {
          let index3 = node_index - moved_offset;
          let changes$1 = prepend(remove2(index3), changes);
          let events$1 = remove_child(cache, events2, path, node_index, prev);
          loop$old = old_remaining;
          loop$old_keyed = old_keyed;
          loop$new = new$5;
          loop$new_keyed = new_keyed;
          loop$moved = moved;
          loop$moved_offset = moved_offset - 1;
          loop$removed = removed;
          loop$node_index = node_index;
          loop$patch_index = patch_index;
          loop$changes = changes$1;
          loop$children = children;
          loop$path = path;
          loop$cache = cache;
          loop$events = events$1;
        } else {
          let change = replace2(node_index - moved_offset, next);
          let $ = replace_child(cache, events2, path, node_index, prev, next);
          let cache$1;
          let events$1;
          cache$1 = $[0];
          events$1 = $[1];
          loop$old = old_remaining;
          loop$old_keyed = old_keyed;
          loop$new = new_remaining;
          loop$new_keyed = new_keyed;
          loop$moved = moved;
          loop$moved_offset = moved_offset;
          loop$removed = removed;
          loop$node_index = node_index + 1;
          loop$patch_index = patch_index;
          loop$changes = prepend(change, changes);
          loop$children = children;
          loop$path = path;
          loop$cache = cache$1;
          loop$events = events$1;
        }
      } else {
        let $ = old.head;
        if ($ instanceof Fragment) {
          let $1 = new$5.head;
          if ($1 instanceof Fragment) {
            let prev2 = $;
            let old$1 = old.tail;
            let next2 = $1;
            let new$1 = new$5.tail;
            let $2 = do_diff(prev2.children, prev2.keyed_children, next2.children, next2.keyed_children, empty2(), 0, 0, 0, node_index, empty_list, empty_list, add2(path, node_index, next2.key), cache, events2);
            let patch;
            let cache$1;
            let events$1;
            patch = $2.patch;
            cache$1 = $2.cache;
            events$1 = $2.events;
            let _block;
            let $3 = patch.changes;
            if ($3 instanceof Empty) {
              let $4 = patch.children;
              if ($4 instanceof Empty) {
                let $5 = patch.removed;
                if ($5 === 0) {
                  _block = children;
                } else {
                  _block = prepend(patch, children);
                }
              } else {
                _block = prepend(patch, children);
              }
            } else {
              _block = prepend(patch, children);
            }
            let children$1 = _block;
            loop$old = old$1;
            loop$old_keyed = old_keyed;
            loop$new = new$1;
            loop$new_keyed = new_keyed;
            loop$moved = moved;
            loop$moved_offset = moved_offset;
            loop$removed = removed;
            loop$node_index = node_index + 1;
            loop$patch_index = patch_index;
            loop$changes = changes;
            loop$children = children$1;
            loop$path = path;
            loop$cache = cache$1;
            loop$events = events$1;
          } else {
            let prev2 = $;
            let old_remaining = old.tail;
            let next2 = $1;
            let new_remaining = new$5.tail;
            let change = replace2(node_index - moved_offset, next2);
            let $2 = replace_child(cache, events2, path, node_index, prev2, next2);
            let cache$1;
            let events$1;
            cache$1 = $2[0];
            events$1 = $2[1];
            loop$old = old_remaining;
            loop$old_keyed = old_keyed;
            loop$new = new_remaining;
            loop$new_keyed = new_keyed;
            loop$moved = moved;
            loop$moved_offset = moved_offset;
            loop$removed = removed;
            loop$node_index = node_index + 1;
            loop$patch_index = patch_index;
            loop$changes = prepend(change, changes);
            loop$children = children;
            loop$path = path;
            loop$cache = cache$1;
            loop$events = events$1;
          }
        } else if ($ instanceof Element) {
          let $1 = new$5.head;
          if ($1 instanceof Element) {
            let prev2 = $;
            let next2 = $1;
            if (prev2.namespace === next2.namespace && prev2.tag === next2.tag) {
              let old$1 = old.tail;
              let new$1 = new$5.tail;
              let child_path = add2(path, node_index, next2.key);
              let controlled = is_controlled(cache, next2.namespace, next2.tag, child_path);
              let $2 = diff_attributes(controlled, child_path, events2, prev2.attributes, next2.attributes, empty_list, empty_list);
              let added_attrs;
              let removed_attrs;
              let events$1;
              added_attrs = $2.added;
              removed_attrs = $2.removed;
              events$1 = $2.events;
              let _block;
              if (added_attrs instanceof Empty && removed_attrs instanceof Empty) {
                _block = empty_list;
              } else {
                _block = toList([update(added_attrs, removed_attrs)]);
              }
              let initial_child_changes = _block;
              let $3 = do_diff(prev2.children, prev2.keyed_children, next2.children, next2.keyed_children, empty2(), 0, 0, 0, node_index, initial_child_changes, empty_list, child_path, cache, events$1);
              let patch;
              let cache$1;
              let events$2;
              patch = $3.patch;
              cache$1 = $3.cache;
              events$2 = $3.events;
              let _block$1;
              let $4 = patch.changes;
              if ($4 instanceof Empty) {
                let $5 = patch.children;
                if ($5 instanceof Empty) {
                  let $6 = patch.removed;
                  if ($6 === 0) {
                    _block$1 = children;
                  } else {
                    _block$1 = prepend(patch, children);
                  }
                } else {
                  _block$1 = prepend(patch, children);
                }
              } else {
                _block$1 = prepend(patch, children);
              }
              let children$1 = _block$1;
              loop$old = old$1;
              loop$old_keyed = old_keyed;
              loop$new = new$1;
              loop$new_keyed = new_keyed;
              loop$moved = moved;
              loop$moved_offset = moved_offset;
              loop$removed = removed;
              loop$node_index = node_index + 1;
              loop$patch_index = patch_index;
              loop$changes = changes;
              loop$children = children$1;
              loop$path = path;
              loop$cache = cache$1;
              loop$events = events$2;
            } else {
              let prev3 = $;
              let old_remaining = old.tail;
              let next3 = $1;
              let new_remaining = new$5.tail;
              let change = replace2(node_index - moved_offset, next3);
              let $2 = replace_child(cache, events2, path, node_index, prev3, next3);
              let cache$1;
              let events$1;
              cache$1 = $2[0];
              events$1 = $2[1];
              loop$old = old_remaining;
              loop$old_keyed = old_keyed;
              loop$new = new_remaining;
              loop$new_keyed = new_keyed;
              loop$moved = moved;
              loop$moved_offset = moved_offset;
              loop$removed = removed;
              loop$node_index = node_index + 1;
              loop$patch_index = patch_index;
              loop$changes = prepend(change, changes);
              loop$children = children;
              loop$path = path;
              loop$cache = cache$1;
              loop$events = events$1;
            }
          } else {
            let prev2 = $;
            let old_remaining = old.tail;
            let next2 = $1;
            let new_remaining = new$5.tail;
            let change = replace2(node_index - moved_offset, next2);
            let $2 = replace_child(cache, events2, path, node_index, prev2, next2);
            let cache$1;
            let events$1;
            cache$1 = $2[0];
            events$1 = $2[1];
            loop$old = old_remaining;
            loop$old_keyed = old_keyed;
            loop$new = new_remaining;
            loop$new_keyed = new_keyed;
            loop$moved = moved;
            loop$moved_offset = moved_offset;
            loop$removed = removed;
            loop$node_index = node_index + 1;
            loop$patch_index = patch_index;
            loop$changes = prepend(change, changes);
            loop$children = children;
            loop$path = path;
            loop$cache = cache$1;
            loop$events = events$1;
          }
        } else if ($ instanceof Text) {
          let $1 = new$5.head;
          if ($1 instanceof Text) {
            let prev2 = $;
            let next2 = $1;
            if (prev2.content === next2.content) {
              let old$1 = old.tail;
              let new$1 = new$5.tail;
              loop$old = old$1;
              loop$old_keyed = old_keyed;
              loop$new = new$1;
              loop$new_keyed = new_keyed;
              loop$moved = moved;
              loop$moved_offset = moved_offset;
              loop$removed = removed;
              loop$node_index = node_index + 1;
              loop$patch_index = patch_index;
              loop$changes = changes;
              loop$children = children;
              loop$path = path;
              loop$cache = cache;
              loop$events = events2;
            } else {
              let old$1 = old.tail;
              let next3 = $1;
              let new$1 = new$5.tail;
              let child2 = new$3(node_index, 0, toList([replace_text(next3.content)]), empty_list);
              loop$old = old$1;
              loop$old_keyed = old_keyed;
              loop$new = new$1;
              loop$new_keyed = new_keyed;
              loop$moved = moved;
              loop$moved_offset = moved_offset;
              loop$removed = removed;
              loop$node_index = node_index + 1;
              loop$patch_index = patch_index;
              loop$changes = changes;
              loop$children = prepend(child2, children);
              loop$path = path;
              loop$cache = cache;
              loop$events = events2;
            }
          } else {
            let prev2 = $;
            let old_remaining = old.tail;
            let next2 = $1;
            let new_remaining = new$5.tail;
            let change = replace2(node_index - moved_offset, next2);
            let $2 = replace_child(cache, events2, path, node_index, prev2, next2);
            let cache$1;
            let events$1;
            cache$1 = $2[0];
            events$1 = $2[1];
            loop$old = old_remaining;
            loop$old_keyed = old_keyed;
            loop$new = new_remaining;
            loop$new_keyed = new_keyed;
            loop$moved = moved;
            loop$moved_offset = moved_offset;
            loop$removed = removed;
            loop$node_index = node_index + 1;
            loop$patch_index = patch_index;
            loop$changes = prepend(change, changes);
            loop$children = children;
            loop$path = path;
            loop$cache = cache$1;
            loop$events = events$1;
          }
        } else if ($ instanceof UnsafeInnerHtml) {
          let $1 = new$5.head;
          if ($1 instanceof UnsafeInnerHtml) {
            let prev2 = $;
            let old$1 = old.tail;
            let next2 = $1;
            let new$1 = new$5.tail;
            let child_path = add2(path, node_index, next2.key);
            let $2 = diff_attributes(false, child_path, events2, prev2.attributes, next2.attributes, empty_list, empty_list);
            let added_attrs;
            let removed_attrs;
            let events$1;
            added_attrs = $2.added;
            removed_attrs = $2.removed;
            events$1 = $2.events;
            let _block;
            if (added_attrs instanceof Empty && removed_attrs instanceof Empty) {
              _block = empty_list;
            } else {
              _block = toList([update(added_attrs, removed_attrs)]);
            }
            let child_changes = _block;
            let _block$1;
            let $3 = prev2.inner_html === next2.inner_html;
            if ($3) {
              _block$1 = child_changes;
            } else {
              _block$1 = prepend(replace_inner_html(next2.inner_html), child_changes);
            }
            let child_changes$1 = _block$1;
            let _block$2;
            if (child_changes$1 instanceof Empty) {
              _block$2 = children;
            } else {
              _block$2 = prepend(new$3(node_index, 0, child_changes$1, toList([])), children);
            }
            let children$1 = _block$2;
            loop$old = old$1;
            loop$old_keyed = old_keyed;
            loop$new = new$1;
            loop$new_keyed = new_keyed;
            loop$moved = moved;
            loop$moved_offset = moved_offset;
            loop$removed = removed;
            loop$node_index = node_index + 1;
            loop$patch_index = patch_index;
            loop$changes = changes;
            loop$children = children$1;
            loop$path = path;
            loop$cache = cache;
            loop$events = events$1;
          } else {
            let prev2 = $;
            let old_remaining = old.tail;
            let next2 = $1;
            let new_remaining = new$5.tail;
            let change = replace2(node_index - moved_offset, next2);
            let $2 = replace_child(cache, events2, path, node_index, prev2, next2);
            let cache$1;
            let events$1;
            cache$1 = $2[0];
            events$1 = $2[1];
            loop$old = old_remaining;
            loop$old_keyed = old_keyed;
            loop$new = new_remaining;
            loop$new_keyed = new_keyed;
            loop$moved = moved;
            loop$moved_offset = moved_offset;
            loop$removed = removed;
            loop$node_index = node_index + 1;
            loop$patch_index = patch_index;
            loop$changes = prepend(change, changes);
            loop$children = children;
            loop$path = path;
            loop$cache = cache$1;
            loop$events = events$1;
          }
        } else if ($ instanceof Map2) {
          let $1 = new$5.head;
          if ($1 instanceof Map2) {
            let prev2 = $;
            let old$1 = old.tail;
            let next2 = $1;
            let new$1 = new$5.tail;
            let child_path = add2(path, node_index, next2.key);
            let child_key = child(child_path);
            let $2 = do_diff(prepend(prev2.child, empty_list), empty2(), prepend(next2.child, empty_list), empty2(), empty2(), 0, 0, 0, node_index, empty_list, empty_list, subtree(child_path), cache, get_subtree(events2, child_key, prev2.mapper));
            let patch;
            let cache$1;
            let child_events;
            patch = $2.patch;
            cache$1 = $2.cache;
            child_events = $2.events;
            let events$1 = update_subtree(events2, child_key, next2.mapper, child_events);
            let _block;
            let $3 = patch.changes;
            if ($3 instanceof Empty) {
              let $4 = patch.children;
              if ($4 instanceof Empty) {
                let $5 = patch.removed;
                if ($5 === 0) {
                  _block = children;
                } else {
                  _block = prepend(patch, children);
                }
              } else {
                _block = prepend(patch, children);
              }
            } else {
              _block = prepend(patch, children);
            }
            let children$1 = _block;
            loop$old = old$1;
            loop$old_keyed = old_keyed;
            loop$new = new$1;
            loop$new_keyed = new_keyed;
            loop$moved = moved;
            loop$moved_offset = moved_offset;
            loop$removed = removed;
            loop$node_index = node_index + 1;
            loop$patch_index = patch_index;
            loop$changes = changes;
            loop$children = children$1;
            loop$path = path;
            loop$cache = cache$1;
            loop$events = events$1;
          } else {
            let prev2 = $;
            let old_remaining = old.tail;
            let next2 = $1;
            let new_remaining = new$5.tail;
            let change = replace2(node_index - moved_offset, next2);
            let $2 = replace_child(cache, events2, path, node_index, prev2, next2);
            let cache$1;
            let events$1;
            cache$1 = $2[0];
            events$1 = $2[1];
            loop$old = old_remaining;
            loop$old_keyed = old_keyed;
            loop$new = new_remaining;
            loop$new_keyed = new_keyed;
            loop$moved = moved;
            loop$moved_offset = moved_offset;
            loop$removed = removed;
            loop$node_index = node_index + 1;
            loop$patch_index = patch_index;
            loop$changes = prepend(change, changes);
            loop$children = children;
            loop$path = path;
            loop$cache = cache$1;
            loop$events = events$1;
          }
        } else {
          let $1 = new$5.head;
          if ($1 instanceof Memo) {
            let prev2 = $;
            let old$1 = old.tail;
            let next2 = $1;
            let new$1 = new$5.tail;
            let $2 = equal_lists(prev2.dependencies, next2.dependencies);
            if ($2) {
              let cache$1 = keep_memo(cache, prev2.view, next2.view);
              loop$old = old$1;
              loop$old_keyed = old_keyed;
              loop$new = new$1;
              loop$new_keyed = new_keyed;
              loop$moved = moved;
              loop$moved_offset = moved_offset;
              loop$removed = removed;
              loop$node_index = node_index + 1;
              loop$patch_index = patch_index;
              loop$changes = changes;
              loop$children = children;
              loop$path = path;
              loop$cache = cache$1;
              loop$events = events2;
            } else {
              let prev_node = get_old_memo(cache, prev2.view, prev2.view);
              let next_node = next2.view();
              let cache$1 = add_memo(cache, next2.view, next_node);
              loop$old = prepend(prev_node, old$1);
              loop$old_keyed = old_keyed;
              loop$new = prepend(next_node, new$1);
              loop$new_keyed = new_keyed;
              loop$moved = moved;
              loop$moved_offset = moved_offset;
              loop$removed = removed;
              loop$node_index = node_index;
              loop$patch_index = patch_index;
              loop$changes = changes;
              loop$children = children;
              loop$path = path;
              loop$cache = cache$1;
              loop$events = events2;
            }
          } else {
            let prev2 = $;
            let old_remaining = old.tail;
            let next2 = $1;
            let new_remaining = new$5.tail;
            let change = replace2(node_index - moved_offset, next2);
            let $2 = replace_child(cache, events2, path, node_index, prev2, next2);
            let cache$1;
            let events$1;
            cache$1 = $2[0];
            events$1 = $2[1];
            loop$old = old_remaining;
            loop$old_keyed = old_keyed;
            loop$new = new_remaining;
            loop$new_keyed = new_keyed;
            loop$moved = moved;
            loop$moved_offset = moved_offset;
            loop$removed = removed;
            loop$node_index = node_index + 1;
            loop$patch_index = patch_index;
            loop$changes = prepend(change, changes);
            loop$children = children;
            loop$path = path;
            loop$cache = cache$1;
            loop$events = events$1;
          }
        }
      }
    }
  }
}
function diff(cache, old, new$5) {
  let cache$1 = tick(cache);
  let $ = do_diff(prepend(old, empty_list), empty2(), prepend(new$5, empty_list), empty2(), empty2(), 0, 0, 0, 0, empty_list, empty_list, root, cache$1, events(cache$1));
  let patch;
  let cache$2;
  let events2;
  patch = $.patch;
  cache$2 = $.cache;
  events2 = $.events;
  return new Diff(patch, update_events(cache$2, events2));
}

// build/dev/javascript/lustre/lustre/internals/list.ffi.mjs
var toList2 = (arr) => arr.reduceRight((xs, x) => List$NonEmpty(x, xs), empty_list);
var iterate = (list4, callback) => {
  if (Array.isArray(list4)) {
    for (let i = 0;i < list4.length; i++) {
      callback(list4[i]);
    }
  } else if (list4) {
    for (list4;List$NonEmpty$rest(list4); list4 = List$NonEmpty$rest(list4)) {
      callback(List$NonEmpty$first(list4));
    }
  }
};
var append4 = (a, b) => {
  if (!List$NonEmpty$rest(a)) {
    return b;
  } else if (!List$NonEmpty$rest(b)) {
    return a;
  } else {
    return append(a, b);
  }
};

// build/dev/javascript/lustre/lustre/internals/constants.ffi.mjs
var NAMESPACE_HTML = "http://www.w3.org/1999/xhtml";
var ELEMENT_NODE = 1;
var TEXT_NODE = 3;
var COMMENT_NODE = 8;
var SUPPORTS_MOVE_BEFORE = !!globalThis.HTMLElement?.prototype?.moveBefore;

// build/dev/javascript/lustre/lustre/vdom/reconciler.ffi.mjs
var setTimeout = globalThis.setTimeout;
var clearTimeout = globalThis.clearTimeout;
var createElementNS = (ns, name) => globalThis.document.createElementNS(ns, name);
var createTextNode = (data2) => globalThis.document.createTextNode(data2);
var createComment = (data2) => globalThis.document.createComment(data2);
var createDocumentFragment = () => globalThis.document.createDocumentFragment();
var insertBefore = (parent, node, reference) => parent.insertBefore(node, reference);
var moveBefore = SUPPORTS_MOVE_BEFORE ? (parent, node, reference) => parent.moveBefore(node, reference) : insertBefore;
var removeChild = (parent, child2) => parent.removeChild(child2);
var getAttribute = (node, name) => node.getAttribute(name);
var setAttribute = (node, name, value) => node.setAttribute(name, value);
var removeAttribute = (node, name) => node.removeAttribute(name);
var addEventListener = (node, name, handler, options) => node.addEventListener(name, handler, options);
var removeEventListener = (node, name, handler) => node.removeEventListener(name, handler);
var setInnerHtml = (node, innerHtml) => node.innerHTML = innerHtml;
var setData = (node, data2) => node.data = data2;
var meta = Symbol("lustre");

class MetadataNode {
  constructor(kind, parent, node, key) {
    this.kind = kind;
    this.key = key;
    this.parent = parent;
    this.children = [];
    this.node = node;
    this.endNode = null;
    this.handlers = new Map;
    this.throttles = new Map;
    this.debouncers = new Map;
  }
  get isVirtual() {
    return this.kind === fragment_kind || this.kind === map_kind;
  }
  get parentNode() {
    return this.isVirtual ? this.node.parentNode : this.node;
  }
}
var insertMetadataChild = (kind, parent, node, index3, key) => {
  const child2 = new MetadataNode(kind, parent, node, key);
  node[meta] = child2;
  parent?.children.splice(index3, 0, child2);
  return child2;
};
var getPath = (node) => {
  let path = "";
  for (let current = node[meta];current.parent; current = current.parent) {
    const separator = current.parent && current.parent.kind === map_kind ? separator_subtree : separator_element;
    if (current.key) {
      path = `${separator}${current.key}${path}`;
    } else {
      const index3 = current.parent.children.indexOf(current);
      path = `${separator}${index3}${path}`;
    }
  }
  return path.slice(1);
};

class Reconciler {
  #root = null;
  #decodeEvent;
  #dispatch;
  #debug = false;
  constructor(root2, decodeEvent, dispatch2, { debug = false } = {}) {
    this.#root = root2;
    this.#decodeEvent = decodeEvent;
    this.#dispatch = dispatch2;
    this.#debug = debug;
  }
  mount(vdom) {
    insertMetadataChild(element_kind, null, this.#root, 0, null);
    this.#insertChild(this.#root, null, this.#root[meta], 0, vdom);
  }
  push(patch, memos2 = null) {
    this.#memos = memos2;
    this.#stack.push({ node: this.#root[meta], patch });
    this.#reconcile();
  }
  #memos;
  #stack = [];
  #reconcile() {
    const stack = this.#stack;
    while (stack.length) {
      const { node, patch } = stack.pop();
      const { children: childNodes } = node;
      const { changes, removed, children: childPatches } = patch;
      iterate(changes, (change) => this.#patch(node, change));
      if (removed) {
        this.#removeChildren(node, childNodes.length - removed, removed);
      }
      iterate(childPatches, (childPatch) => {
        const child2 = childNodes[childPatch.index | 0];
        this.#stack.push({ node: child2, patch: childPatch });
      });
    }
  }
  #patch(node, change) {
    switch (change.kind) {
      case replace_text_kind:
        this.#replaceText(node, change);
        break;
      case replace_inner_html_kind:
        this.#replaceInnerHtml(node, change);
        break;
      case update_kind:
        this.#update(node, change);
        break;
      case move_kind:
        this.#move(node, change);
        break;
      case remove_kind:
        this.#remove(node, change);
        break;
      case replace_kind:
        this.#replace(node, change);
        break;
      case insert_kind:
        this.#insert(node, change);
        break;
    }
  }
  #insert(parent, { children, before }) {
    const fragment2 = createDocumentFragment();
    const beforeEl = this.#getReference(parent, before);
    this.#insertChildren(fragment2, null, parent, before | 0, children);
    insertBefore(parent.parentNode, fragment2, beforeEl);
  }
  #replace(parent, { index: index3, with: child2 }) {
    this.#removeChildren(parent, index3 | 0, 1);
    const beforeEl = this.#getReference(parent, index3);
    this.#insertChild(parent.parentNode, beforeEl, parent, index3 | 0, child2);
  }
  #getReference(node, index3) {
    index3 = index3 | 0;
    const { children } = node;
    const childCount = children.length;
    if (index3 < childCount)
      return children[index3].node;
    if (node.endNode)
      return node.endNode;
    if (!node.isVirtual)
      return null;
    while (node.isVirtual && node.children.length) {
      if (node.endNode)
        return node.endNode.nextSibling;
      node = node.children[node.children.length - 1];
    }
    return node.node.nextSibling;
  }
  #move(parent, { key, before }) {
    before = before | 0;
    const { children, parentNode } = parent;
    const beforeEl = children[before].node;
    let prev = children[before];
    for (let i = before + 1;i < children.length; ++i) {
      const next = children[i];
      children[i] = prev;
      prev = next;
      if (next.key === key) {
        children[before] = next;
        break;
      }
    }
    this.#moveChild(parentNode, prev, beforeEl);
  }
  #moveChildren(domParent, children, beforeEl) {
    for (let i = 0;i < children.length; ++i) {
      this.#moveChild(domParent, children[i], beforeEl);
    }
  }
  #moveChild(domParent, child2, beforeEl) {
    moveBefore(domParent, child2.node, beforeEl);
    if (child2.isVirtual) {
      this.#moveChildren(domParent, child2.children, beforeEl);
    }
    if (child2.endNode) {
      moveBefore(domParent, child2.endNode, beforeEl);
    }
  }
  #remove(parent, { index: index3 }) {
    this.#removeChildren(parent, index3, 1);
  }
  #removeChildren(parent, index3, count) {
    const { children, parentNode } = parent;
    const deleted = children.splice(index3, count);
    for (let i = 0;i < deleted.length; ++i) {
      const child2 = deleted[i];
      const { node, endNode, isVirtual, children: nestedChildren } = child2;
      removeChild(parentNode, node);
      if (endNode) {
        removeChild(parentNode, endNode);
      }
      this.#removeDebouncers(child2);
      if (isVirtual) {
        deleted.push(...nestedChildren);
      }
    }
  }
  #removeDebouncers(node) {
    const { debouncers, children } = node;
    for (const { timeout } of debouncers.values()) {
      if (timeout) {
        clearTimeout(timeout);
      }
    }
    debouncers.clear();
    iterate(children, (child2) => this.#removeDebouncers(child2));
  }
  #update({ node, handlers, throttles, debouncers }, { added, removed }) {
    iterate(removed, ({ name }) => {
      if (handlers.delete(name)) {
        removeEventListener(node, name, handleEvent);
        this.#updateDebounceThrottle(throttles, name, 0);
        this.#updateDebounceThrottle(debouncers, name, 0);
      } else {
        removeAttribute(node, name);
        SYNCED_ATTRIBUTES[name]?.removed?.(node, name);
      }
    });
    iterate(added, (attribute3) => this.#createAttribute(node, attribute3));
  }
  #replaceText({ node }, { content }) {
    setData(node, content ?? "");
  }
  #replaceInnerHtml({ node }, { inner_html }) {
    setInnerHtml(node, inner_html ?? "");
  }
  #insertChildren(domParent, beforeEl, metaParent, index3, children) {
    iterate(children, (child2) => this.#insertChild(domParent, beforeEl, metaParent, index3++, child2));
  }
  #insertChild(domParent, beforeEl, metaParent, index3, vnode) {
    switch (vnode.kind) {
      case element_kind: {
        const node = this.#createElement(metaParent, index3, vnode);
        this.#insertChildren(node, null, node[meta], 0, vnode.children);
        insertBefore(domParent, node, beforeEl);
        break;
      }
      case text_kind: {
        const node = this.#createTextNode(metaParent, index3, vnode);
        insertBefore(domParent, node, beforeEl);
        break;
      }
      case fragment_kind: {
        const marker = "lustre:fragment";
        const head = this.#createHead(marker, metaParent, index3, vnode);
        insertBefore(domParent, head, beforeEl);
        this.#insertChildren(domParent, beforeEl, head[meta], 0, vnode.children);
        if (this.#debug) {
          head[meta].endNode = createComment(` /${marker} `);
          insertBefore(domParent, head[meta].endNode, beforeEl);
        }
        break;
      }
      case unsafe_inner_html_kind: {
        const node = this.#createElement(metaParent, index3, vnode);
        this.#replaceInnerHtml({ node }, vnode);
        insertBefore(domParent, node, beforeEl);
        break;
      }
      case map_kind: {
        const head = this.#createHead("lustre:map", metaParent, index3, vnode);
        insertBefore(domParent, head, beforeEl);
        this.#insertChild(domParent, beforeEl, head[meta], 0, vnode.child);
        break;
      }
      case memo_kind: {
        const child2 = this.#memos?.get(vnode.view) ?? vnode.view();
        this.#insertChild(domParent, beforeEl, metaParent, index3, child2);
        break;
      }
    }
  }
  #createElement(parent, index3, { kind, key, tag, namespace, attributes }) {
    const node = createElementNS(namespace || NAMESPACE_HTML, tag);
    insertMetadataChild(kind, parent, node, index3, key);
    if (this.#debug && key) {
      setAttribute(node, "data-lustre-key", key);
    }
    iterate(attributes, (attribute3) => this.#createAttribute(node, attribute3));
    return node;
  }
  #createTextNode(parent, index3, { kind, key, content }) {
    const node = createTextNode(content ?? "");
    insertMetadataChild(kind, parent, node, index3, key);
    return node;
  }
  #createHead(marker, parent, index3, { kind, key }) {
    const node = this.#debug ? createComment(markerComment(marker, key)) : createTextNode("");
    insertMetadataChild(kind, parent, node, index3, key);
    return node;
  }
  #createAttribute(node, attribute3) {
    const { debouncers, handlers, throttles } = node[meta];
    const {
      kind,
      name,
      value,
      prevent_default: prevent,
      debounce: debounceDelay,
      throttle: throttleDelay
    } = attribute3;
    switch (kind) {
      case attribute_kind: {
        const valueOrDefault = value ?? "";
        if (name === "virtual:defaultValue") {
          node.defaultValue = valueOrDefault;
          return;
        } else if (name === "virtual:defaultChecked") {
          node.defaultChecked = true;
          return;
        } else if (name === "virtual:defaultSelected") {
          node.defaultSelected = true;
          return;
        }
        if (valueOrDefault !== getAttribute(node, name)) {
          setAttribute(node, name, valueOrDefault);
        }
        SYNCED_ATTRIBUTES[name]?.added?.(node, valueOrDefault);
        break;
      }
      case property_kind:
        node[name] = value;
        break;
      case event_kind: {
        if (handlers.has(name)) {
          removeEventListener(node, name, handleEvent);
        }
        const passive = prevent.kind === never_kind;
        addEventListener(node, name, handleEvent, { passive });
        this.#updateDebounceThrottle(throttles, name, throttleDelay);
        this.#updateDebounceThrottle(debouncers, name, debounceDelay);
        handlers.set(name, (event3) => this.#handleEvent(attribute3, event3));
        break;
      }
    }
  }
  #updateDebounceThrottle(map7, name, delay) {
    const debounceOrThrottle = map7.get(name);
    if (delay > 0) {
      if (debounceOrThrottle) {
        debounceOrThrottle.delay = delay;
      } else {
        map7.set(name, { delay });
      }
    } else if (debounceOrThrottle) {
      const { timeout } = debounceOrThrottle;
      if (timeout) {
        clearTimeout(timeout);
      }
      map7.delete(name);
    }
  }
  #handleEvent(attribute3, event3) {
    const { currentTarget, type } = event3;
    const { debouncers, throttles } = currentTarget[meta];
    const path = getPath(currentTarget);
    const {
      prevent_default: prevent,
      stop_propagation: stop,
      include
    } = attribute3;
    if (prevent.kind === always_kind)
      event3.preventDefault();
    if (stop.kind === always_kind)
      event3.stopPropagation();
    if (type === "submit") {
      event3.detail ??= {};
      event3.detail.formData = [
        ...new FormData(event3.target, event3.submitter).entries()
      ];
    }
    const data2 = this.#decodeEvent(event3, path, type, include);
    const throttle = throttles.get(type);
    if (throttle) {
      const now = Date.now();
      const last = throttle.last || 0;
      if (now > last + throttle.delay) {
        throttle.last = now;
        throttle.lastEvent = event3;
        this.#dispatch(event3, data2);
      }
    }
    const debounce = debouncers.get(type);
    if (debounce) {
      clearTimeout(debounce.timeout);
      debounce.timeout = setTimeout(() => {
        if (event3 === throttles.get(type)?.lastEvent)
          return;
        this.#dispatch(event3, data2);
      }, debounce.delay);
    }
    if (!throttle && !debounce) {
      this.#dispatch(event3, data2);
    }
  }
}
var markerComment = (marker, key) => {
  if (key) {
    return ` ${marker} key="${escape2(key)}" `;
  } else {
    return ` ${marker} `;
  }
};
var handleEvent = (event3) => {
  const { currentTarget, type } = event3;
  const handler = currentTarget[meta].handlers.get(type);
  handler(event3);
};
var syncedBooleanAttribute = (name) => {
  return {
    added(node) {
      node[name] = true;
    },
    removed(node) {
      node[name] = false;
    }
  };
};
var syncedAttribute = (name) => {
  return {
    added(node, value) {
      node[name] = value;
    }
  };
};
var SYNCED_ATTRIBUTES = {
  checked: syncedBooleanAttribute("checked"),
  selected: syncedBooleanAttribute("selected"),
  value: syncedAttribute("value"),
  autofocus: {
    added(node) {
      queueMicrotask(() => {
        node.focus?.();
      });
    }
  },
  autoplay: {
    added(node) {
      try {
        node.play?.();
      } catch (e) {
        console.error(e);
      }
    }
  }
};

// build/dev/javascript/lustre/lustre/element/keyed.mjs
function do_extract_keyed_children(loop$key_children_pairs, loop$keyed_children, loop$children) {
  while (true) {
    let key_children_pairs = loop$key_children_pairs;
    let keyed_children = loop$keyed_children;
    let children = loop$children;
    if (key_children_pairs instanceof Empty) {
      return [keyed_children, reverse(children)];
    } else {
      let rest = key_children_pairs.tail;
      let key = key_children_pairs.head[0];
      let element$1 = key_children_pairs.head[1];
      let keyed_element = to_keyed(key, element$1);
      let _block;
      if (key === "") {
        _block = keyed_children;
      } else {
        _block = insert2(keyed_children, key, keyed_element);
      }
      let keyed_children$1 = _block;
      let children$1 = prepend(keyed_element, children);
      loop$key_children_pairs = rest;
      loop$keyed_children = keyed_children$1;
      loop$children = children$1;
    }
  }
}
function extract_keyed_children(children) {
  return do_extract_keyed_children(children, empty2(), empty_list);
}
function element3(tag, attributes, children) {
  let $ = extract_keyed_children(children);
  let keyed_children;
  let children$1;
  keyed_children = $[0];
  children$1 = $[1];
  return element("", "", tag, attributes, children$1, keyed_children, false, is_void_html_element(tag, ""));
}
function namespaced2(namespace, tag, attributes, children) {
  let $ = extract_keyed_children(children);
  let keyed_children;
  let children$1;
  keyed_children = $[0];
  children$1 = $[1];
  return element("", namespace, tag, attributes, children$1, keyed_children, false, is_void_html_element(tag, namespace));
}
function fragment2(children) {
  let $ = extract_keyed_children(children);
  let keyed_children;
  let children$1;
  keyed_children = $[0];
  children$1 = $[1];
  return fragment("", children$1, keyed_children);
}

// build/dev/javascript/lustre/lustre/vdom/virtualise.ffi.mjs
var virtualise = (root2) => {
  const rootMeta = insertMetadataChild(element_kind, null, root2, 0, null);
  for (let child2 = root2.firstChild;child2; child2 = child2.nextSibling) {
    const result = virtualiseChild(rootMeta, root2, child2, 0);
    if (result)
      return result.vnode;
  }
  const placeholder = globalThis.document.createTextNode("");
  insertMetadataChild(text_kind, rootMeta, placeholder, 0, null);
  root2.insertBefore(placeholder, root2.firstChild);
  return none3();
};
var virtualiseChild = (meta2, domParent, child2, index3) => {
  if (child2.nodeType === COMMENT_NODE) {
    const data2 = child2.data.trim();
    if (data2.startsWith("lustre:fragment")) {
      return virtualiseFragment(meta2, domParent, child2, index3);
    }
    if (data2.startsWith("lustre:map")) {
      return virtualiseMap(meta2, domParent, child2, index3);
    }
    if (data2.startsWith("lustre:memo")) {
      return virtualiseMemo(meta2, domParent, child2, index3);
    }
    return null;
  }
  if (child2.nodeType === ELEMENT_NODE) {
    return virtualiseElement(meta2, child2, index3);
  }
  if (child2.nodeType === TEXT_NODE) {
    return virtualiseText(meta2, child2, index3);
  }
  return null;
};
var virtualiseElement = (metaParent, node, index3) => {
  const key = node.getAttribute("data-lustre-key") ?? "";
  if (key) {
    node.removeAttribute("data-lustre-key");
  }
  const meta2 = insertMetadataChild(element_kind, metaParent, node, index3, key);
  const tag = node.localName;
  const namespace = node.namespaceURI;
  const isHtmlElement = !namespace || namespace === NAMESPACE_HTML;
  if (isHtmlElement && INPUT_ELEMENTS.includes(tag)) {
    virtualiseInputEvents(tag, node);
  }
  const attributes = virtualiseAttributes(node);
  const children = [];
  for (let childNode = node.firstChild;childNode; ) {
    const child2 = virtualiseChild(meta2, node, childNode, children.length);
    if (child2) {
      children.push([child2.key, child2.vnode]);
      childNode = child2.next;
    } else {
      childNode = childNode.nextSibling;
    }
  }
  const vnode = isHtmlElement ? element3(tag, attributes, toList3(children)) : namespaced2(namespace, tag, attributes, toList3(children));
  return childResult(key, vnode, node.nextSibling);
};
var virtualiseText = (meta2, node, index3) => {
  insertMetadataChild(text_kind, meta2, node, index3, null);
  return childResult("", text2(node.data), node.nextSibling);
};
var virtualiseFragment = (metaParent, domParent, node, index3) => {
  const key = parseKey(node.data);
  const meta2 = insertMetadataChild(fragment_kind, metaParent, node, index3, key);
  const children = [];
  node = node.nextSibling;
  while (node && (node.nodeType !== COMMENT_NODE || node.data.trim() !== "/lustre:fragment")) {
    const child2 = virtualiseChild(meta2, domParent, node, children.length);
    if (child2) {
      children.push([child2.key, child2.vnode]);
      node = child2.next;
    } else {
      node = node.nextSibling;
    }
  }
  meta2.endNode = node;
  const vnode = fragment2(toList3(children));
  return childResult(key, vnode, node?.nextSibling);
};
var virtualiseMap = (metaParent, domParent, node, index3) => {
  const key = parseKey(node.data);
  const meta2 = insertMetadataChild(map_kind, metaParent, node, index3, key);
  const child2 = virtualiseNextChild(meta2, domParent, node, 0);
  if (!child2)
    return null;
  const vnode = map6(child2.vnode, (x) => x);
  return childResult(key, vnode, child2.next);
};
var virtualiseMemo = (meta2, domParent, node, index3) => {
  const key = parseKey(node.data);
  const child2 = virtualiseNextChild(meta2, domParent, node, index3);
  if (!child2)
    return null;
  domParent.removeChild(node);
  const vnode = memo2(toList3([ref({})]), () => child2.vnode);
  return childResult(key, vnode, child2.next);
};
var virtualiseNextChild = (meta2, domParent, node, index3) => {
  while (true) {
    node = node.nextSibling;
    if (!node)
      return null;
    const child2 = virtualiseChild(meta2, domParent, node, index3);
    if (child2)
      return child2;
  }
};
var childResult = (key, vnode, next) => {
  return { key, vnode, next };
};
var virtualiseAttributes = (node) => {
  const attributes = [];
  for (let i = 0;i < node.attributes.length; i++) {
    const attr = node.attributes[i];
    if (attr.name !== "xmlns") {
      attributes.push(attribute2(attr.localName, attr.value));
    }
  }
  return toList3(attributes);
};
var INPUT_ELEMENTS = ["input", "select", "textarea"];
var virtualiseInputEvents = (tag, node) => {
  const value = node.value;
  const checked = node.checked;
  if (tag === "input" && node.type === "checkbox" && !checked)
    return;
  if (tag === "input" && node.type === "radio" && !checked)
    return;
  if (node.type !== "checkbox" && node.type !== "radio" && !value)
    return;
  queueMicrotask(() => {
    node.value = value;
    node.checked = checked;
    node.dispatchEvent(new Event("input", { bubbles: true }));
    node.dispatchEvent(new Event("change", { bubbles: true }));
    if (globalThis.document.activeElement !== node) {
      node.dispatchEvent(new Event("blur", { bubbles: true }));
    }
  });
};
var parseKey = (data2) => {
  const keyMatch = data2.match(/key="([^"]*)"/);
  if (!keyMatch)
    return "";
  return unescapeKey(keyMatch[1]);
};
var unescapeKey = (key) => {
  return key.replace(/&lt;/g, "<").replace(/&gt;/g, ">").replace(/&quot;/g, '"').replace(/&amp;/g, "&").replace(/&#39;/g, "'");
};
var toList3 = (arr) => arr.reduceRight((xs, x) => List$NonEmpty(x, xs), empty_list);

// build/dev/javascript/lustre/lustre/runtime/client/runtime.ffi.mjs
var is_browser = () => !!globalThis.document;
class Runtime {
  constructor(root2, [model, effects], view, update2, options) {
    this.root = root2;
    this.#model = model;
    this.#view = view;
    this.#update = update2;
    this.root.addEventListener("context-request", (event3) => {
      if (!(event3.context && event3.callback))
        return;
      if (!this.#contexts.has(event3.context))
        return;
      event3.stopImmediatePropagation();
      const context = this.#contexts.get(event3.context);
      if (event3.subscribe) {
        const unsubscribe = () => {
          context.subscribers = context.subscribers.filter((subscriber) => subscriber !== event3.callback);
        };
        context.subscribers.push([event3.callback, unsubscribe]);
        event3.callback(context.value, unsubscribe);
      } else {
        event3.callback(context.value);
      }
    });
    const decodeEvent = (event3, path, name) => decode2(this.#cache, path, name, event3);
    const dispatch2 = (event3, data2) => {
      const [cache, result] = dispatch(this.#cache, data2);
      this.#cache = cache;
      if (Result$isOk(result)) {
        const handler = Result$Ok$0(result);
        if (handler.stop_propagation)
          event3.stopPropagation();
        if (handler.prevent_default)
          event3.preventDefault();
        this.dispatch(handler.message, false);
      }
    };
    this.#reconciler = new Reconciler(this.root, decodeEvent, dispatch2, options);
    this.#vdom = virtualise(this.root);
    this.#cache = new$4();
    this.#handleEffects(effects);
    this.#render();
  }
  root = null;
  dispatch(msg, shouldFlush = false) {
    if (this.#shouldQueue) {
      this.#queue.push(msg);
    } else {
      const [model, effects] = this.#update(this.#model, msg);
      this.#model = model;
      this.#tick(effects, shouldFlush);
    }
  }
  emit(event3, data2) {
    const target = this.root.host ?? this.root;
    target.dispatchEvent(new CustomEvent(event3, {
      detail: data2,
      bubbles: true,
      composed: true
    }));
  }
  provide(key, value) {
    if (!this.#contexts.has(key)) {
      this.#contexts.set(key, { value, subscribers: [] });
    } else {
      const context = this.#contexts.get(key);
      if (isEqual2(context.value, value)) {
        return;
      }
      context.value = value;
      for (let i = context.subscribers.length - 1;i >= 0; i--) {
        const [subscriber, unsubscribe] = context.subscribers[i];
        if (!subscriber) {
          context.subscribers.splice(i, 1);
          continue;
        }
        subscriber(value, unsubscribe);
      }
    }
  }
  #model;
  #view;
  #update;
  #vdom;
  #cache;
  #reconciler;
  #contexts = new Map;
  #shouldQueue = false;
  #queue = [];
  #beforePaint = empty_list;
  #afterPaint = empty_list;
  #renderTimer = null;
  #actions = {
    dispatch: (msg) => this.dispatch(msg),
    emit: (event3, data2) => this.emit(event3, data2),
    select: () => {},
    root: () => this.root,
    provide: (key, value) => this.provide(key, value)
  };
  #tick(effects, shouldFlush = false) {
    this.#handleEffects(effects);
    if (!this.#renderTimer) {
      if (shouldFlush) {
        this.#renderTimer = "sync";
        queueMicrotask(() => this.#render());
      } else {
        this.#renderTimer = window.requestAnimationFrame(() => this.#render());
      }
    }
  }
  #handleEffects(effects) {
    this.#shouldQueue = true;
    while (true) {
      iterate(effects.synchronous, (effect) => effect(this.#actions));
      this.#beforePaint = append4(this.#beforePaint, effects.before_paint);
      this.#afterPaint = append4(this.#afterPaint, effects.after_paint);
      if (!this.#queue.length)
        break;
      const msg = this.#queue.shift();
      [this.#model, effects] = this.#update(this.#model, msg);
    }
    this.#shouldQueue = false;
  }
  #render() {
    this.#renderTimer = null;
    const next = this.#view(this.#model);
    const { patch, cache } = diff(this.#cache, this.#vdom, next);
    this.#cache = cache;
    this.#vdom = next;
    this.#reconciler.push(patch, memos(cache));
    if (List$isNonEmpty(this.#beforePaint)) {
      const effects = makeEffect(this.#beforePaint);
      this.#beforePaint = empty_list;
      queueMicrotask(() => {
        this.#tick(effects, true);
      });
    }
    if (List$isNonEmpty(this.#afterPaint)) {
      const effects = makeEffect(this.#afterPaint);
      this.#afterPaint = empty_list;
      window.requestAnimationFrame(() => this.#tick(effects, true));
    }
  }
}
function makeEffect(synchronous) {
  return {
    synchronous,
    after_paint: empty_list,
    before_paint: empty_list
  };
}
var copiedStyleSheets = new WeakMap;

// build/dev/javascript/lustre/lustre/runtime/client/spa.ffi.mjs
class Spa {
  #runtime;
  constructor(root2, [init, effects], update2, view) {
    this.#runtime = new Runtime(root2, [init, effects], view, update2);
  }
  send(message) {
    if (Message$isEffectDispatchedMessage(message)) {
      this.dispatch(message.message, false);
    } else if (Message$isEffectEmitEvent(message)) {
      this.emit(message.name, message.data);
    } else if (Message$isSystemRequestedShutdown(message)) {}
  }
  dispatch(msg) {
    this.#runtime.dispatch(msg);
  }
  emit(event3, data2) {
    this.#runtime.emit(event3, data2);
  }
}
var start = ({ init, update: update2, view }, selector, flags) => {
  if (!is_browser())
    return Result$Error(Error$NotABrowser());
  const root2 = selector instanceof HTMLElement ? selector : globalThis.document.querySelector(selector);
  if (!root2)
    return Result$Error(Error$ElementNotFound(selector));
  return Result$Ok(new Spa(root2, init(flags), update2, view));
};

// build/dev/javascript/lustre/lustre/runtime/server/runtime.ffi.mjs
class Runtime2 {
  #model;
  #update;
  #view;
  #config;
  #vdom;
  #cache;
  #providers = make();
  #callbacks = /* @__PURE__ */ new Set;
  constructor(_, init, update2, view, config2, start_arguments) {
    const [model, effects] = init(start_arguments);
    this.#model = model;
    this.#update = update2;
    this.#view = view;
    this.#config = config2;
    this.#vdom = this.#view(this.#model);
    this.#cache = from_node(this.#vdom);
    this.#handle_effect(effects);
  }
  send(msg) {
    if (Message$isClientDispatchedMessage(msg)) {
      const { message } = msg;
      const next = this.#handle_client_message(message);
      const diff2 = diff(this.#cache, this.#vdom, next);
      this.#vdom = next;
      this.#cache = diff2.cache;
      this.broadcast(reconcile(diff2.patch, memos(diff2.cache)));
    } else if (Message$isClientRegisteredCallback(msg)) {
      const { callback } = msg;
      this.#callbacks.add(callback);
      callback(mount(this.#config.open_shadow_root, this.#config.adopt_styles, keys(this.#config.attributes), keys(this.#config.properties), keys(this.#config.contexts), this.#providers, this.#vdom, memos(this.#cache)));
      if (Option$isSome(config.on_connect)) {
        this.#dispatch(Option$Some$0(config.on_connect));
      }
    } else if (Message$isClientDeregisteredCallback(msg)) {
      const { callback } = msg;
      this.#callbacks.delete(callback);
      if (Option$isSome(config.on_disconnect)) {
        this.#dispatch(Option$Some$0(config.on_disconnect));
      }
    } else if (Message$isEffectDispatchedMessage(msg)) {
      const { message } = msg;
      const [model, effect] = this.#update(this.#model, message);
      const next = this.#view(model);
      const diff2 = diff(this.#cache, this.#vdom, next);
      this.#handle_effect(effect);
      this.#model = model;
      this.#vdom = next;
      this.#cache = diff2.cache;
      this.broadcast(reconcile(diff2.patch, memos(diff2.cache)));
    } else if (Message$isEffectEmitEvent(msg)) {
      const { name, data: data2 } = msg;
      this.broadcast(emit(name, data2));
    } else if (Message$isEffectProvidedValue(msg)) {
      const { key, value } = msg;
      const existing = get(this.#providers, key);
      if (Result$isOk(existing) && isEqual2(Result$Ok$0(existing), value)) {
        return;
      }
      this.#providers = insert(this.#providers, key, value);
      this.broadcast(provide(key, value));
    } else if (Message$isSystemRequestedShutdown(msg)) {
      this.#model = null;
      this.#update = null;
      this.#view = null;
      this.#config = null;
      this.#vdom = null;
      this.#cache = null;
      this.#providers = null;
      this.#callbacks.clear();
    }
  }
  broadcast(msg) {
    for (const callback of this.#callbacks) {
      callback(msg);
    }
  }
  #handle_client_message(msg) {
    if (ServerMessage$isBatch(msg)) {
      const { messages } = msg;
      let model = this.#model;
      let effect = none2();
      for (let list4 = messages;List$NonEmpty$rest(list4); list4 = List$NonEmpty$rest(list4)) {
        const result = this.#handle_client_message(List$NonEmpty$first(list4));
        if (Result$isOk(result)) {
          model = Result$Ok$0(result)[0];
          effect = batch(toList2([effect, Result$Ok$0(result)[1]]));
          break;
        }
      }
      this.#handle_effect(effect);
      this.#model = model;
      return this.#view(model);
    } else if (ServerMessage$isAttributeChanged(msg)) {
      const { name, value } = msg;
      const result = this.#handle_attribute_change(name, value);
      if (!Result$isOk(result)) {
        return this.#vdom;
      }
      return this.#dispatch(Result$Ok$0(result));
    } else if (ServerMessage$isPropertyChanged(msg)) {
      const { name, value } = msg;
      const result = this.#handle_properties_change(name, value);
      if (!Result$isOk(result)) {
        return this.#vdom;
      }
      return this.#dispatch(Result$Ok$0(result));
    } else if (ServerMessage$isEventFired(msg)) {
      const { path, name, event: event3 } = msg;
      const [cache, result] = handle(this.#cache, path, name, event3);
      this.#cache = cache;
      if (!Result$isOk(result)) {
        return this.#vdom;
      }
      const { message } = Result$Ok$0(result);
      return this.#dispatch(message);
    } else if (ServerMessage$isContextProvided(msg)) {
      const { key, value } = msg;
      let result = get(this.#config.contexts, key);
      if (!Result$isOk(result)) {
        return this.#vdom;
      }
      result = run(value, Result$Ok$0(result));
      if (!Result$isOk(result)) {
        return this.#vdom;
      }
      return this.#dispatch(Result$Ok$0(result));
    }
  }
  #dispatch(msg) {
    const [model, effects] = this.#update(this.#model, msg);
    this.#handle_effect(effects);
    this.#model = model;
    return this.#view(this.#model);
  }
  #handle_attribute_change(name, value) {
    const result = get(this.#config.attributes, name);
    if (!Result$isOk(result)) {
      return result;
    }
    return Result$Ok$0(result)(value);
  }
  #handle_properties_change(name, value) {
    const result = get(this.#config.properties, name);
    if (!Result$isOk(result)) {
      return result;
    }
    return Result$Ok$0(result)(value);
  }
  #handle_effect(effect) {
    const dispatch2 = (message) => this.send(Message$EffectDispatchedMessage(message));
    const emit2 = (name, data2) => this.send(Message$EffectEmitEvent(name, data2));
    const select = () => {
      return;
    };
    const internals = () => {
      return;
    };
    const provide2 = (key, value) => this.send(Message$EffectProvidedValue(key, value));
    globalThis.queueMicrotask(() => {
      perform(effect, dispatch2, emit2, select, internals, provide2);
    });
  }
}

// build/dev/javascript/lustre/lustre.mjs
class ElementNotFound extends CustomType {
  constructor(selector) {
    super();
    this.selector = selector;
  }
}
var Error$ElementNotFound = (selector) => new ElementNotFound(selector);
class NotABrowser extends CustomType {
}
var Error$NotABrowser = () => new NotABrowser;
function application(init, update2, view) {
  return new App(new None, init, update2, view, default_config);
}
function start4(app, selector, arguments$) {
  return guard(!is_browser(), new Error(new NotABrowser), () => {
    return start(app, selector, arguments$);
  });
}
// build/dev/javascript/showcase/model.mjs
class Home extends CustomType {
}
class AppBar extends CustomType {
}
class Button extends CustomType {
}
class Calendar extends CustomType {
}
class Datepicker extends CustomType {
}
class Icon extends CustomType {
}
class Switch extends CustomType {
}
class Model extends CustomType {
  constructor(date_str, state) {
    super();
    this.date_str = date_str;
    this.state = state;
  }
}

// build/dev/javascript/showcase/msg.mjs
class HomeSelected extends CustomType {
}
class AppBarPageSelected extends CustomType {
}
class ButtonSelected extends CustomType {
}
class CalendarSelected extends CustomType {
  constructor($0) {
    super();
    this[0] = $0;
  }
}
class DatepickerSelected extends CustomType {
  constructor($0, $1) {
    super();
    this[0] = $0;
    this[1] = $1;
  }
}
class IconPageSelected extends CustomType {
}
class SwitchPageSelected extends CustomType {
}
class CalendarDateSelected extends CustomType {
  constructor($0) {
    super();
    this[0] = $0;
  }
}
class CalendarDateFetched extends CustomType {
  constructor($0) {
    super();
    this[0] = $0;
  }
}
class CalendarBlackoutAttached extends CustomType {
}
class DatepickerReady extends CustomType {
}

// build/dev/javascript/showcase/init.mjs
var initial_date = "2026-04-01";
function init(_) {
  return [new Model(initial_date, new Button), none2()];
}

// build/dev/javascript/showcase/components/calendar.ffi.mjs
function date(id2) {
  const calendar = document.querySelector(`#${id2}`);
  if (calendar === null)
    return "calendar is null";
  const date2 = calendar.date;
  const day = date2.getDate();
  const month = date2.getMonth() + 1;
  const year = date2.getFullYear();
  return year.toString() + "-" + month.toString().padStart(2, "0") + "-" + day.toString().padStart(2, "0");
}
function is_blackout_date(date2) {
  const d = new Date(date2);
  const day = d.getDay();
  const blackout = day % 6 === 0;
  return blackout;
}
function attach_blackout_func(selector) {
  const el = document.querySelector(selector);
  if (el) {
    el.blackoutDates = (date2) => is_blackout_date(date2);
  }
}

// build/dev/javascript/showcase/components/calendar_effects.mjs
function attach_blackout_function(id2) {
  return after_paint((dispatch2, _) => {
    attach_blackout_func(id2);
    return dispatch2(new CalendarBlackoutAttached);
  });
}
function get_date(id2) {
  return from2((dispatch2) => {
    let d = date(id2);
    return dispatch2(new CalendarDateFetched(d));
  });
}

// build/dev/javascript/showcase/components/datepicker.ffi.mjs
function attach_change_handler(picker_id, input_id) {
  const picker = document.querySelector(picker_id);
  const input2 = document.querySelector(input_id);
  picker.addEventListener("change", () => {
    input2.value = picker.date.toLocaleDateString();
  });
}

// build/dev/javascript/showcase/components/datepicker_effects.mjs
function attach_change_handler2(picker_id, input_id) {
  return after_paint((dispatch2, _) => {
    attach_change_handler(picker_id, input_id);
    return dispatch2(new DatepickerReady);
  });
}

// build/dev/javascript/showcase/update.mjs
function update2(model, msg) {
  if (msg instanceof HomeSelected) {
    return [new Model(model.date_str, new Home), none2()];
  } else if (msg instanceof AppBarPageSelected) {
    return [new Model(model.date_str, new AppBar), none2()];
  } else if (msg instanceof ButtonSelected) {
    return [new Model(model.date_str, new Button), none2()];
  } else if (msg instanceof CalendarSelected) {
    let id2 = msg[0];
    return [
      new Model(model.date_str, new Calendar),
      attach_blackout_function(id2)
    ];
  } else if (msg instanceof DatepickerSelected) {
    let picker_id = msg[0];
    let input_id = msg[1];
    return [
      new Model(model.date_str, new Datepicker),
      attach_change_handler2(picker_id, input_id)
    ];
  } else if (msg instanceof IconPageSelected) {
    return [new Model(model.date_str, new Icon), none2()];
  } else if (msg instanceof SwitchPageSelected) {
    return [new Model(model.date_str, new Switch), none2()];
  } else if (msg instanceof CalendarDateSelected) {
    let id2 = msg[0];
    return [model, get_date(id2)];
  } else if (msg instanceof CalendarDateFetched) {
    let date2 = msg[0];
    let _block;
    let _pipe = first(split2(date2, "T"));
    _block = unwrap(_pipe, initial_date);
    let the_date = _block;
    return [new Model(the_date, model.state), none2()];
  } else if (msg instanceof CalendarBlackoutAttached) {
    return [model, none2()];
  } else {
    return [model, none2()];
  }
}

// build/dev/javascript/lustre/lustre/event.mjs
function on(name, handler) {
  return event(name, map3(handler, (msg) => {
    return new Handler(false, false, msg);
  }), empty_list, never, never, 0, 0);
}
function on_click(msg) {
  return on("click", success(msg));
}
// build/dev/javascript/m3e/m3e/app_bar_size.mjs
class Small extends CustomType {
}
class Medium extends CustomType {
}
class Large extends CustomType {
}
function to_string4(level) {
  if (level instanceof Small) {
    return "small";
  } else if (level instanceof Medium) {
    return "medium";
  } else {
    return "large";
  }
}

// build/dev/javascript/m3e/m3e/attr.mjs
function boolean(name, value) {
  if (value) {
    return attribute2(name, "");
  } else {
    return none();
  }
}
function option(option2, attribute_name_func, attribute_value_func, default_value) {
  let $ = or(option2, default_value);
  if ($ instanceof Some) {
    let v = $[0];
    return attribute2(attribute_name_func(v), attribute_value_func(v));
  } else {
    return none();
  }
}
function with_default(name, value, default$) {
  let $ = value !== default$;
  if ($) {
    return attribute2(name, value);
  } else {
    return none();
  }
}

// build/dev/javascript/m3e/m3e/app_bar.mjs
class AppBar2 extends CustomType {
  constructor(centered, for$2, size3) {
    super();
    this.centered = centered;
    this.for = for$2;
    this.size = size3;
  }
}

class IsCentered extends CustomType {
}
class IsNotCentered extends CustomType {
}
class Leading extends CustomType {
}
class Subtitle extends CustomType {
}
class Title extends CustomType {
}
class Trailing extends CustomType {
}
class LeadingIcon extends CustomType {
}
class Config3 extends CustomType {
  constructor(centered, for$2, size3) {
    super();
    this.centered = centered;
    this.for = for$2;
    this.size = size3;
  }
}
var default_for = /* @__PURE__ */ new None;
var default_size = /* @__PURE__ */ new Small;
function default_config2() {
  return new Config3(new IsNotCentered, new None, new Small);
}
function from_config(config2) {
  return new AppBar2(config2.centered, config2.for, config2.size);
}
function new$6() {
  return from_config(default_config2());
}
function centered(record, centered2) {
  return new AppBar2(centered2, record.for, record.size);
}
function for$2(record, for$3) {
  return new AppBar2(record.centered, for$3, record.size);
}
function size3(record, size4) {
  return new AppBar2(record.centered, record.for, size4);
}
function slot2(s) {
  if (s instanceof Leading) {
    return attribute2("slot", "leading");
  } else if (s instanceof Subtitle) {
    return attribute2("slot", "subtitle");
  } else if (s instanceof Title) {
    return attribute2("slot", "title");
  } else if (s instanceof Trailing) {
    return attribute2("slot", "trailing");
  } else if (s instanceof LeadingIcon) {
    return attribute2("slot", "leading-icon");
  } else {
    return attribute2("slot", "trailing-icon");
  }
}
function render(model, attributes, children) {
  return element2("m3e-app-bar", (() => {
    let _pipe = flatten(toList([
      toList([
        boolean("centered", model.centered instanceof IsCentered),
        option(model.for, (_) => {
          return "for";
        }, identity2, default_for),
        with_default("size", to_string4(model.size), to_string4(default_size))
      ]),
      attributes
    ]));
    return filter(_pipe, (a) => {
      return !isEqual(a, none());
    });
  })(), children);
}

// build/dev/javascript/m3e/m3e/color_scheme.mjs
class Light extends CustomType {
}
class Dark extends CustomType {
}
class Auto extends CustomType {
}
function to_string5(level) {
  if (level instanceof Light) {
    return "light";
  } else if (level instanceof Dark) {
    return "dark";
  } else {
    return "auto";
  }
}

// build/dev/javascript/m3e/m3e/contrast_level.mjs
class High extends CustomType {
}
class Medium2 extends CustomType {
}
class Standard extends CustomType {
}
function to_string6(level) {
  if (level instanceof High) {
    return "high";
  } else if (level instanceof Medium2) {
    return "medium";
  } else {
    return "standard";
  }
}

// build/dev/javascript/m3e/m3e/drawer_mode.mjs
class Over extends CustomType {
}
class Push extends CustomType {
}
class Side extends CustomType {
}
class Auto2 extends CustomType {
}
function to_string7(level) {
  if (level instanceof Over) {
    return "over";
  } else if (level instanceof Push) {
    return "push";
  } else if (level instanceof Side) {
    return "side";
  } else {
    return "auto";
  }
}

// build/dev/javascript/m3e/m3e/drawer_container.mjs
class DrawerContainer extends CustomType {
  constructor(end, end_mode, end_divider, start5, start_mode, start_divider) {
    super();
    this.end = end;
    this.end_mode = end_mode;
    this.end_divider = end_divider;
    this.start = start5;
    this.start_mode = start_mode;
    this.start_divider = start_divider;
  }
}

class IsEnd extends CustomType {
}
class IsNotEnd extends CustomType {
}
class IsEndDivider extends CustomType {
}
class IsNotEndDivider extends CustomType {
}
class IsStart extends CustomType {
}
class IsNotStart extends CustomType {
}
class IsStartDivider extends CustomType {
}
class IsNotStartDivider extends CustomType {
}
class Start extends CustomType {
}
class Config4 extends CustomType {
  constructor(end, end_mode, end_divider, start5, start_mode, start_divider) {
    super();
    this.end = end;
    this.end_mode = end_mode;
    this.end_divider = end_divider;
    this.start = start5;
    this.start_mode = start_mode;
    this.start_divider = start_divider;
  }
}
var default_end_mode = /* @__PURE__ */ new Side;
var default_start_mode = /* @__PURE__ */ new Side;
function default_config3() {
  return new Config4(new IsNotEnd, new Side, new IsNotEndDivider, new IsNotStart, new Side, new IsNotStartDivider);
}
function from_config2(config2) {
  return new DrawerContainer(config2.end, config2.end_mode, config2.end_divider, config2.start, config2.start_mode, config2.start_divider);
}
function slot3(s) {
  if (s instanceof Start) {
    return attribute2("slot", "start");
  } else {
    return attribute2("slot", "end");
  }
}
function render2(model, attributes, children) {
  return element2("m3e-drawer-container", (() => {
    let _pipe = flatten(toList([
      toList([
        boolean("end", model.end instanceof IsEnd),
        with_default("end-mode", to_string7(model.end_mode), to_string7(default_end_mode)),
        boolean("end-divider", model.end_divider instanceof IsEndDivider),
        boolean("start", model.start instanceof IsStart),
        with_default("start-mode", to_string7(model.start_mode), to_string7(default_start_mode)),
        boolean("start-divider", model.start_divider instanceof IsStartDivider)
      ]),
      attributes
    ]));
    return filter(_pipe, (a) => {
      return !isEqual(a, none());
    });
  })(), children);
}
function render_config(c, attributes, children) {
  return render2(from_config2(c), attributes, children);
}

// build/dev/javascript/m3e/m3e/drawer_toggle.mjs
class DrawerToggle extends CustomType {
  constructor(for$3) {
    super();
    this.for = for$3;
  }
}
var default_for2 = /* @__PURE__ */ new None;
function new$7(for$3) {
  return new DrawerToggle(for$3);
}
function render3(model, attributes, children) {
  return element2("m3e-drawer-toggle", (() => {
    let _pipe = flatten(toList([
      toList([
        option(model.for, (_) => {
          return "for";
        }, identity2, default_for2)
      ]),
      attributes
    ]));
    return filter(_pipe, (a) => {
      return !isEqual(a, none());
    });
  })(), children);
}

// build/dev/javascript/m3e/m3e/icon_grade.mjs
class Low extends CustomType {
}
class Medium3 extends CustomType {
}
function to_string8(level) {
  if (level instanceof Low) {
    return "low";
  } else if (level instanceof Medium3) {
    return "medium";
  } else {
    return "high";
  }
}

// build/dev/javascript/m3e/m3e/icon_variant.mjs
class Outlined extends CustomType {
}
class Rounded extends CustomType {
}
class Sharp extends CustomType {
}
function to_string9(level) {
  if (level instanceof Outlined) {
    return "outlined";
  } else if (level instanceof Rounded) {
    return "rounded";
  } else {
    return "sharp";
  }
}

// build/dev/javascript/m3e/m3e/icon_weight.mjs
class OneZeroZero extends CustomType {
}
class TwoZeroZero extends CustomType {
}
class ThreeZeroZero extends CustomType {
}
class FourZeroZero extends CustomType {
}
class FiveZeroZero extends CustomType {
}
class SixZeroZero extends CustomType {
}
function to_string10(level) {
  if (level instanceof OneZeroZero) {
    return "100";
  } else if (level instanceof TwoZeroZero) {
    return "200";
  } else if (level instanceof ThreeZeroZero) {
    return "300";
  } else if (level instanceof FourZeroZero) {
    return "400";
  } else if (level instanceof FiveZeroZero) {
    return "500";
  } else if (level instanceof SixZeroZero) {
    return "600";
  } else {
    return "700";
  }
}

// build/dev/javascript/m3e/m3e/icon.mjs
class Icon2 extends CustomType {
  constructor(filled, grade, optical_size, name, variant, weight) {
    super();
    this.filled = filled;
    this.grade = grade;
    this.optical_size = optical_size;
    this.name = name;
    this.variant = variant;
    this.weight = weight;
  }
}

class IsFilled extends CustomType {
}
class IsNotFilled extends CustomType {
}
class Config5 extends CustomType {
  constructor(filled, grade, optical_size, name, variant, weight) {
    super();
    this.filled = filled;
    this.grade = grade;
    this.optical_size = optical_size;
    this.name = name;
    this.variant = variant;
    this.weight = weight;
  }
}
var default_grade = /* @__PURE__ */ new Medium3;
var default_optical_size = 24;
var default_name = "";
var default_variant = /* @__PURE__ */ new Outlined;
var default_weight = /* @__PURE__ */ new FourZeroZero;
function default_config4() {
  return new Config5(new IsNotFilled, new Medium3, 24, "", new Outlined, new FourZeroZero);
}
function from_config3(config2) {
  return new Icon2(config2.filled, config2.grade, config2.optical_size, config2.name, config2.variant, config2.weight);
}
function new$8() {
  return from_config3(default_config4());
}
function filled(record, filled2) {
  return new Icon2(filled2, record.grade, record.optical_size, record.name, record.variant, record.weight);
}
function name(record, name2) {
  return new Icon2(record.filled, record.grade, record.optical_size, name2, record.variant, record.weight);
}
function variant(record, variant2) {
  return new Icon2(record.filled, record.grade, record.optical_size, record.name, variant2, record.weight);
}
function render4(model, attributes, children) {
  return element2("m3e-icon", (() => {
    let _pipe = flatten(toList([
      toList([
        boolean("filled", model.filled instanceof IsFilled),
        with_default("grade", to_string8(model.grade), to_string8(default_grade)),
        with_default("optical-size", float_to_string(model.optical_size), float_to_string(default_optical_size)),
        with_default("name", model.name, default_name),
        with_default("variant", to_string9(model.variant), to_string9(default_variant)),
        with_default("weight", to_string10(model.weight), to_string10(default_weight))
      ]),
      attributes
    ]));
    return filter(_pipe, (a) => {
      return !isEqual(a, none());
    });
  })(), children);
}

// build/dev/javascript/m3e/m3e/form_submitter_type.mjs
class Button2 extends CustomType {
}
class Submit extends CustomType {
}
function to_string11(level) {
  if (level instanceof Button2) {
    return "button";
  } else if (level instanceof Submit) {
    return "submit";
  } else {
    return "reset";
  }
}

// build/dev/javascript/m3e/m3e/icon_button_shape.mjs
class Rounded2 extends CustomType {
}
function to_string12(level) {
  if (level instanceof Rounded2) {
    return "rounded";
  } else {
    return "square";
  }
}

// build/dev/javascript/m3e/m3e/icon_button_size.mjs
class ExtraSmall extends CustomType {
}
class Small2 extends CustomType {
}
class Medium4 extends CustomType {
}
class Large2 extends CustomType {
}
function to_string13(level) {
  if (level instanceof ExtraSmall) {
    return "extra-small";
  } else if (level instanceof Small2) {
    return "small";
  } else if (level instanceof Medium4) {
    return "medium";
  } else if (level instanceof Large2) {
    return "large";
  } else {
    return "extra-large";
  }
}

// build/dev/javascript/m3e/m3e/icon_button_variant.mjs
class Filled extends CustomType {
}
class Tonal extends CustomType {
}
class Outlined2 extends CustomType {
}
class Standard2 extends CustomType {
}
function to_string14(level) {
  if (level instanceof Filled) {
    return "filled";
  } else if (level instanceof Tonal) {
    return "tonal";
  } else if (level instanceof Outlined2) {
    return "outlined";
  } else {
    return "standard";
  }
}

// build/dev/javascript/m3e/m3e/icon_button_width.mjs
class Default extends CustomType {
}
class Narrow extends CustomType {
}
function to_string15(level) {
  if (level instanceof Default) {
    return "default";
  } else if (level instanceof Narrow) {
    return "narrow";
  } else {
    return "wide";
  }
}

// build/dev/javascript/m3e/m3e/link_target.mjs
class Self extends CustomType {
}
class Blank extends CustomType {
}
class Parent extends CustomType {
}
function to_string16(level) {
  if (level instanceof Self) {
    return "_self";
  } else if (level instanceof Blank) {
    return "_blank";
  } else if (level instanceof Parent) {
    return "_parent";
  } else {
    return "_top";
  }
}

// build/dev/javascript/m3e/m3e/icon_button.mjs
class IconButton extends CustomType {
  constructor(disabled, disabled_interactive, download, href, name2, rel, selected, shape, size4, target, toggle, type_, value, variant2, width) {
    super();
    this.disabled = disabled;
    this.disabled_interactive = disabled_interactive;
    this.download = download;
    this.href = href;
    this.name = name2;
    this.rel = rel;
    this.selected = selected;
    this.shape = shape;
    this.size = size4;
    this.target = target;
    this.toggle = toggle;
    this.type_ = type_;
    this.value = value;
    this.variant = variant2;
    this.width = width;
  }
}

class IsDisabled extends CustomType {
}
class IsNotDisabled extends CustomType {
}
class IsDisabledInteractive extends CustomType {
}
class IsNotDisabledInteractive extends CustomType {
}
class IsSelected extends CustomType {
}
class IsNotSelected extends CustomType {
}
class IsToggle extends CustomType {
}
class IsNotToggle extends CustomType {
}
class Selected extends CustomType {
}
class Config6 extends CustomType {
  constructor(disabled, disabled_interactive, download, href, name2, rel, selected, shape, size4, target, toggle, type_, value, variant2, width) {
    super();
    this.disabled = disabled;
    this.disabled_interactive = disabled_interactive;
    this.download = download;
    this.href = href;
    this.name = name2;
    this.rel = rel;
    this.selected = selected;
    this.shape = shape;
    this.size = size4;
    this.target = target;
    this.toggle = toggle;
    this.type_ = type_;
    this.value = value;
    this.variant = variant2;
    this.width = width;
  }
}
var default_download = /* @__PURE__ */ new None;
var default_href = "";
var default_name2 = "";
var default_rel = "";
var default_shape = /* @__PURE__ */ new Rounded2;
var default_size2 = /* @__PURE__ */ new Small2;
var default_target = /* @__PURE__ */ new None;
var default_type_ = /* @__PURE__ */ new Button2;
var default_value = "";
var default_variant2 = /* @__PURE__ */ new Standard2;
var default_width = /* @__PURE__ */ new Default;
function default_config5() {
  return new Config6(new IsNotDisabled, new IsNotDisabledInteractive, new None, "", "", "", new IsNotSelected, new Rounded2, new Small2, new None, new IsNotToggle, new Button2, "", new Standard2, new Default);
}
function from_config4(config2) {
  return new IconButton(config2.disabled, config2.disabled_interactive, config2.download, config2.href, config2.name, config2.rel, config2.selected, config2.shape, config2.size, config2.target, config2.toggle, config2.type_, config2.value, config2.variant, config2.width);
}
function new$9() {
  return from_config4(default_config5());
}
function href(record, href2) {
  return new IconButton(record.disabled, record.disabled_interactive, record.download, href2, record.name, record.rel, record.selected, record.shape, record.size, record.target, record.toggle, record.type_, record.value, record.variant, record.width);
}
function selected(record, selected2) {
  return new IconButton(record.disabled, record.disabled_interactive, record.download, record.href, record.name, record.rel, selected2, record.shape, record.size, record.target, record.toggle, record.type_, record.value, record.variant, record.width);
}
function toggle(record, toggle2) {
  return new IconButton(record.disabled, record.disabled_interactive, record.download, record.href, record.name, record.rel, record.selected, record.shape, record.size, record.target, toggle2, record.type_, record.value, record.variant, record.width);
}
function slot4(s) {
  return attribute2("slot", "selected");
}
function render5(model, attributes, children) {
  return element2("m3e-icon-button", (() => {
    let _pipe = flatten(toList([
      toList([
        boolean("disabled", model.disabled instanceof IsDisabled),
        boolean("disabled-interactive", model.disabled_interactive instanceof IsDisabledInteractive),
        option(model.download, (_) => {
          return "download";
        }, identity2, default_download),
        with_default("href", model.href, default_href),
        with_default("name", model.name, default_name2),
        with_default("rel", model.rel, default_rel),
        boolean("selected", model.selected instanceof IsSelected),
        with_default("shape", to_string12(model.shape), to_string12(default_shape)),
        with_default("size", to_string13(model.size), to_string13(default_size2)),
        option(model.target, (_) => {
          return "target";
        }, to_string16, default_target),
        boolean("toggle", model.toggle instanceof IsToggle),
        with_default("type", to_string11(model.type_), to_string11(default_type_)),
        with_default("value", model.value, default_value),
        with_default("variant", to_string14(model.variant), to_string14(default_variant2)),
        with_default("width", to_string15(model.width), to_string15(default_width))
      ]),
      attributes
    ]));
    return filter(_pipe, (a) => {
      return !isEqual(a, none());
    });
  })(), children);
}

// build/dev/javascript/m3e/m3e/nav_menu.mjs
class NavMenu extends CustomType {
}
function new$10() {
  return new NavMenu;
}
function render6(_, attributes, children) {
  return element2("m3e-nav-menu", attributes, children);
}

// build/dev/javascript/m3e/m3e/nav_menu_item.mjs
class NavMenuItem extends CustomType {
  constructor(disabled, open, selected2) {
    super();
    this.disabled = disabled;
    this.open = open;
    this.selected = selected2;
  }
}

class IsDisabled2 extends CustomType {
}
class IsNotDisabled2 extends CustomType {
}
class IsOpen extends CustomType {
}
class IsNotOpen extends CustomType {
}
class IsSelected2 extends CustomType {
}
class IsNotSelected2 extends CustomType {
}
class Label extends CustomType {
}
class Icon3 extends CustomType {
}
class Badge extends CustomType {
}
class SelectedIcon extends CustomType {
}
class Config7 extends CustomType {
  constructor(disabled, open, selected2) {
    super();
    this.disabled = disabled;
    this.open = open;
    this.selected = selected2;
  }
}
function default_config6() {
  return new Config7(new IsNotDisabled2, new IsNotOpen, new IsNotSelected2);
}
function from_config5(config2) {
  return new NavMenuItem(config2.disabled, config2.open, config2.selected);
}
function new$11() {
  return from_config5(default_config6());
}
function render7(model, attributes, children) {
  return element2("m3e-nav-menu-item", (() => {
    let _pipe = flatten(toList([
      toList([
        boolean("disabled", model.disabled instanceof IsDisabled2),
        boolean("open", model.open instanceof IsOpen),
        boolean("selected", model.selected instanceof IsSelected2)
      ]),
      attributes
    ]));
    return filter(_pipe, (a) => {
      return !isEqual(a, none());
    });
  })(), children);
}
function slot5(s) {
  if (s instanceof Label) {
    return attribute2("slot", "label");
  } else if (s instanceof Icon3) {
    return attribute2("slot", "icon");
  } else if (s instanceof Badge) {
    return attribute2("slot", "badge");
  } else if (s instanceof SelectedIcon) {
    return attribute2("slot", "selected-icon");
  } else {
    return attribute2("slot", "toggle-icon");
  }
}

// build/dev/javascript/m3e/m3e/motion_scheme.mjs
class Standard3 extends CustomType {
}
function to_string17(level) {
  if (level instanceof Standard3) {
    return "standard";
  } else {
    return "expressive";
  }
}

// build/dev/javascript/m3e/m3e/theme.mjs
class Theme extends CustomType {
  constructor(color, contrast, density, scheme, strong_focus, motion) {
    super();
    this.color = color;
    this.contrast = contrast;
    this.density = density;
    this.scheme = scheme;
    this.strong_focus = strong_focus;
    this.motion = motion;
  }
}

class IsStrongFocus extends CustomType {
}
class IsNotStrongFocus extends CustomType {
}
class Config8 extends CustomType {
  constructor(color, contrast, density, scheme, strong_focus, motion) {
    super();
    this.color = color;
    this.contrast = contrast;
    this.density = density;
    this.scheme = scheme;
    this.strong_focus = strong_focus;
    this.motion = motion;
  }
}
var default_color = "#6750A4";
var default_contrast = /* @__PURE__ */ new Standard;
var default_density = 0;
var default_scheme = /* @__PURE__ */ new Auto;
var default_motion = /* @__PURE__ */ new Standard3;
function default_config7() {
  return new Config8("#6750A4", new Standard, 0, new Auto, new IsNotStrongFocus, new Standard3);
}
function from_config6(config2) {
  return new Theme(config2.color, config2.contrast, config2.density, config2.scheme, config2.strong_focus, config2.motion);
}
function new$12() {
  return from_config6(default_config7());
}
function contrast(record, contrast2) {
  return new Theme(record.color, contrast2, record.density, record.scheme, record.strong_focus, record.motion);
}
function scheme(record, scheme2) {
  return new Theme(record.color, record.contrast, record.density, scheme2, record.strong_focus, record.motion);
}
function render8(model, attributes, children) {
  return element2("m3e-theme", (() => {
    let _pipe = flatten(toList([
      toList([
        with_default("color", model.color, default_color),
        with_default("contrast", to_string6(model.contrast), to_string6(default_contrast)),
        with_default("density", float_to_string(model.density), float_to_string(default_density)),
        with_default("scheme", to_string5(model.scheme), to_string5(default_scheme)),
        boolean("strong-focus", model.strong_focus instanceof IsStrongFocus),
        with_default("motion", to_string17(model.motion), to_string17(default_motion))
      ]),
      attributes
    ]));
    return filter(_pipe, (a) => {
      return !isEqual(a, none());
    });
  })(), children);
}

// build/dev/javascript/m3e/m3e/tooltip_position.mjs
class Above extends CustomType {
}
class Below extends CustomType {
}
class Before extends CustomType {
}
function to_string18(level) {
  if (level instanceof Above) {
    return "above";
  } else if (level instanceof Below) {
    return "below";
  } else if (level instanceof Before) {
    return "before";
  } else {
    return "after";
  }
}

// build/dev/javascript/m3e/m3e/tooltip_touch_gestures.mjs
class Auto3 extends CustomType {
}
class On extends CustomType {
}
function to_string19(level) {
  if (level instanceof Auto3) {
    return "auto";
  } else if (level instanceof On) {
    return "on";
  } else {
    return "off";
  }
}

// build/dev/javascript/m3e/m3e/tooltip.mjs
class Tooltip extends CustomType {
  constructor(disabled, for$3, hide_delay, position, show_delay, touch_gestures) {
    super();
    this.disabled = disabled;
    this.for = for$3;
    this.hide_delay = hide_delay;
    this.position = position;
    this.show_delay = show_delay;
    this.touch_gestures = touch_gestures;
  }
}

class IsDisabled3 extends CustomType {
}
class IsNotDisabled3 extends CustomType {
}
class Config9 extends CustomType {
  constructor(disabled, for$3, hide_delay, position, show_delay, touch_gestures) {
    super();
    this.disabled = disabled;
    this.for = for$3;
    this.hide_delay = hide_delay;
    this.position = position;
    this.show_delay = show_delay;
    this.touch_gestures = touch_gestures;
  }
}
var default_for3 = /* @__PURE__ */ new None;
var default_hide_delay = 200;
var default_position = /* @__PURE__ */ new Below;
var default_show_delay = 0;
var default_touch_gestures = /* @__PURE__ */ new Auto3;
function default_config8() {
  return new Config9(new IsNotDisabled3, new None, 200, new Below, 0, new Auto3);
}
function from_config7(config2) {
  return new Tooltip(config2.disabled, config2.for, config2.hide_delay, config2.position, config2.show_delay, config2.touch_gestures);
}
function new$13() {
  return from_config7(default_config8());
}
function for$3(record, for$4) {
  return new Tooltip(record.disabled, for$4, record.hide_delay, record.position, record.show_delay, record.touch_gestures);
}
function render9(model, attributes, children) {
  return element2("m3e-tooltip", (() => {
    let _pipe = flatten(toList([
      toList([
        boolean("disabled", model.disabled instanceof IsDisabled3),
        option(model.for, (_) => {
          return "for";
        }, identity2, default_for3),
        with_default("hide-delay", float_to_string(model.hide_delay), float_to_string(default_hide_delay)),
        with_default("position", to_string18(model.position), to_string18(default_position)),
        with_default("show-delay", float_to_string(model.show_delay), float_to_string(default_show_delay)),
        with_default("touch-gestures", to_string19(model.touch_gestures), to_string19(default_touch_gestures))
      ]),
      attributes
    ]));
    return filter(_pipe, (a) => {
      return !isEqual(a, none());
    });
  })(), children);
}

// build/dev/javascript/monks_of_style/monks/align_items.mjs
var stretch = ["align-items", "stretch"];
var center = ["align-items", "center"];

// build/dev/javascript/monks_of_style/monks/display.mjs
var flex = ["display", "flex"];

// build/dev/javascript/monks_of_style/monks/flex_grow.mjs
function raw(value) {
  return ["flex-grow", value];
}
// build/dev/javascript/monks_of_style/monks/height.mjs
function raw2(value) {
  return ["height", value];
}

// build/dev/javascript/monks_of_style/monks/justify_content.mjs
var center2 = ["justify-content", "center"];
var flex_start = ["justify-content", "flex-start"];

// build/dev/javascript/monks_of_style/monks/overflow_y.mjs
function raw3(value) {
  return ["overflow-y", value];
}

// build/dev/javascript/monks_of_style/monks/position.mjs
var sticky = ["position", "sticky"];

// build/dev/javascript/monks_of_style/monks/top.mjs
function raw4(value) {
  return ["top", value];
}

// build/dev/javascript/showcase/package.mjs
class Package extends CustomType {
  constructor(state, label2, view, msg) {
    super();
    this.state = state;
    this.label = label2;
    this.view = view;
    this.msg = msg;
  }
}

// build/dev/javascript/m3e/m3e/card_orientation.mjs
class Horizontal extends CustomType {
}
class Vertical extends CustomType {
}
function to_string20(level) {
  if (level instanceof Horizontal) {
    return "horizontal";
  } else {
    return "vertical";
  }
}

// build/dev/javascript/m3e/m3e/card_variant.mjs
class Elevated extends CustomType {
}
class Filled2 extends CustomType {
}
class Outlined3 extends CustomType {
}
function to_string21(level) {
  if (level instanceof Elevated) {
    return "elevated";
  } else if (level instanceof Filled2) {
    return "filled";
  } else {
    return "outlined";
  }
}

// build/dev/javascript/m3e/m3e/card.mjs
class Card extends CustomType {
  constructor(actionable, inline, orientation, variant2, href2, target, rel, download, name2, value, type_, disabled_interactive, disabled) {
    super();
    this.actionable = actionable;
    this.inline = inline;
    this.orientation = orientation;
    this.variant = variant2;
    this.href = href2;
    this.target = target;
    this.rel = rel;
    this.download = download;
    this.name = name2;
    this.value = value;
    this.type_ = type_;
    this.disabled_interactive = disabled_interactive;
    this.disabled = disabled;
  }
}

class IsActionable extends CustomType {
}
class IsNotActionable extends CustomType {
}
class IsInline extends CustomType {
}
class IsNotInline extends CustomType {
}
class IsDisabledInteractive2 extends CustomType {
}
class IsNotDisabledInteractive2 extends CustomType {
}
class IsDisabled4 extends CustomType {
}
class IsNotDisabled4 extends CustomType {
}
class Header extends CustomType {
}
class Content extends CustomType {
}
class Actions2 extends CustomType {
}
class Config10 extends CustomType {
  constructor(actionable, inline, orientation, variant2, href2, target, rel, download, name2, value, type_, disabled_interactive, disabled) {
    super();
    this.actionable = actionable;
    this.inline = inline;
    this.orientation = orientation;
    this.variant = variant2;
    this.href = href2;
    this.target = target;
    this.rel = rel;
    this.download = download;
    this.name = name2;
    this.value = value;
    this.type_ = type_;
    this.disabled_interactive = disabled_interactive;
    this.disabled = disabled;
  }
}
var default_orientation = /* @__PURE__ */ new Vertical;
var default_variant3 = /* @__PURE__ */ new Filled2;
var default_href2 = "";
var default_target2 = /* @__PURE__ */ new None;
var default_rel2 = "";
var default_download2 = /* @__PURE__ */ new None;
var default_name3 = "";
var default_value2 = "";
var default_type_2 = /* @__PURE__ */ new Button2;
function default_config9() {
  return new Config10(new IsNotActionable, new IsNotInline, new Vertical, new Filled2, "", new None, "", new None, "", "", new Button2, new IsNotDisabledInteractive2, new IsNotDisabled4);
}
function from_config8(config2) {
  return new Card(config2.actionable, config2.inline, config2.orientation, config2.variant, config2.href, config2.target, config2.rel, config2.download, config2.name, config2.value, config2.type_, config2.disabled_interactive, config2.disabled);
}
function slot6(s) {
  if (s instanceof Header) {
    return attribute2("slot", "header");
  } else if (s instanceof Content) {
    return attribute2("slot", "content");
  } else if (s instanceof Actions2) {
    return attribute2("slot", "actions");
  } else {
    return attribute2("slot", "footer");
  }
}
function render10(model, attributes, children) {
  return element2("m3e-card", (() => {
    let _pipe = flatten(toList([
      toList([
        boolean("actionable", model.actionable instanceof IsActionable),
        boolean("inline", model.inline instanceof IsInline),
        with_default("orientation", to_string20(model.orientation), to_string20(default_orientation)),
        with_default("variant", to_string21(model.variant), to_string21(default_variant3)),
        with_default("href", model.href, default_href2),
        option(model.target, (_) => {
          return "target";
        }, to_string16, default_target2),
        with_default("rel", model.rel, default_rel2),
        option(model.download, (_) => {
          return "download";
        }, identity2, default_download2),
        with_default("name", model.name, default_name3),
        with_default("value", model.value, default_value2),
        with_default("type", to_string11(model.type_), to_string11(default_type_2)),
        boolean("disabled-interactive", model.disabled_interactive instanceof IsDisabledInteractive2),
        boolean("disabled", model.disabled instanceof IsDisabled4)
      ]),
      attributes
    ]));
    return filter(_pipe, (a) => {
      return !isEqual(a, none());
    });
  })(), children);
}
function render_config2(c, attributes, children) {
  return render10(from_config8(c), attributes, children);
}

// build/dev/javascript/monks_of_style/monks/flex.mjs
var none4 = ["flex", "none"];

// build/dev/javascript/monks_of_style/monks/flex_direction.mjs
var column = ["flex-direction", "column"];

// build/dev/javascript/monks_of_style/monks/gap.mjs
function raw5(value) {
  return ["gap", value];
}

// build/dev/javascript/monks_of_style/monks/padding.mjs
function raw6(value) {
  return ["padding", value];
}

// build/dev/javascript/monks_of_style/monks/z_index.mjs
function raw7(value) {
  return ["z-index", value];
}

// build/dev/javascript/showcase/layout.mjs
function app_bar_style() {
  return styles(toList([none4, raw7("4")]));
}
function app_bar_title_style() {
  return styles(toList([flex]));
}
function card_style() {
  return styles(toList([flex]));
}
function flex_column() {
  return styles(toList([flex, column]));
}
function gap(g) {
  return raw5("calc(var(--spacing) * " + to_string(g) + ")");
}
function button_style() {
  return styles(toList([flex, center, gap(5)]));
}
function frame_style() {
  return styles(toList([stretch, flex, column, gap(5)]));
}
function icon_style() {
  return styles(toList([flex, gap(5)]));
}
function pad(p) {
  return raw6("calc(var(--spacing) * " + to_string(p) + ")");
}
function card_content_style() {
  return styles(toList([
    center,
    flex,
    flex_start,
    gap(5),
    pad(2)
  ]));
}
function switch_style() {
  return styles(toList([flex, center, gap(5)]));
}

// build/dev/javascript/showcase/view_helpers.mjs
function page(displays) {
  return div(toList([frame_style()]), displays);
}
function panel(model, description, content) {
  return render_config2((() => {
    let _record = default_config9();
    return new Config10(_record.actionable, _record.inline, _record.orientation, new Outlined3, _record.href, _record.target, _record.rel, _record.download, _record.name, _record.value, _record.type_, _record.disabled_interactive, _record.disabled);
  })(), toList([card_style()]), toList([
    div(toList([card_content_style(), slot6(new Content)]), toList([text2(description), content(model)]))
  ]));
}

// build/dev/javascript/showcase/components/app_bar_.mjs
function anatomy(_) {
  return div(toList([styles(toList([raw("1")]))]), toList([
    (() => {
      let _pipe = new$6();
      return render(_pipe, toList([]), content());
    })()
  ]));
}
function content() {
  return toList([
    (() => {
      let _pipe = new$9();
      return render5(_pipe, toList([slot2(new Leading)]), toList([
        (() => {
          let _pipe$1 = new$8();
          let _pipe$2 = name(_pipe$1, "arrow_back");
          return render4(_pipe$2, toList([]), toList([]));
        })()
      ]));
    })(),
    span(toList([slot2(new Title)]), toList([text2("Top 10 hiking trails")])),
    span(toList([slot2(new Subtitle)]), toList([text2("Discover popular trails")])),
    (() => {
      let _pipe = new$9();
      return render5(_pipe, toList([slot2(new Trailing)]), toList([
        (() => {
          let _pipe$1 = new$8();
          let _pipe$2 = name(_pipe$1, "bookmark");
          return render4(_pipe$2, toList([]), toList([]));
        })()
      ]));
    })()
  ]);
}
function app_bar(model) {
  return page(toList([
    panel(model, "Anatomy", anatomy),
    panel(model, "Sizes", sizes),
    panel(model, "Centered", centered2),
    panel(model, "Scroll effects", scroll_effects)
  ]));
}
function sizes(_) {
  return div(toList([styles(toList([raw("1")]))]), toList([
    (() => {
      let _pipe = new$6();
      let _pipe$1 = size3(_pipe, new Medium);
      return render(_pipe$1, toList([]), content());
    })(),
    (() => {
      let _pipe = new$6();
      let _pipe$1 = size3(_pipe, new Large);
      return render(_pipe$1, toList([]), content());
    })()
  ]));
}
function centered2(_) {
  return div(toList([styles(toList([raw("1")]))]), toList([
    (() => {
      let _pipe = new$6();
      let _pipe$1 = centered(_pipe, new IsCentered);
      return render(_pipe$1, toList([]), content());
    })()
  ]));
}
function scroll_effects(_) {
  return div(toList([styles(toList([raw("1")]))]), toList([
    div(toList([
      id("scrollContainer"),
      styles(toList([
        raw("1"),
        raw3("auto"),
        raw2("300px")
      ]))
    ]), toList([
      (() => {
        let _pipe = new$6();
        let _pipe$1 = for$2(_pipe, new Some("scrollContainer"));
        return render(_pipe$1, toList([
          styles(toList([sticky, raw4("0")]))
        ]), content());
      })(),
      div(toList([
        styles(toList([
          raw2("400px"),
          flex,
          center,
          center2
        ]))
      ]), toList([text2("Scroll down to see the elevation effect")]))
    ]))
  ]));
}
function package$() {
  return new Package(new AppBar, "App Bar", app_bar, new AppBarPageSelected);
}

// build/dev/javascript/m3e/m3e/button_shape.mjs
class Rounded3 extends CustomType {
}
class Square extends CustomType {
}
function to_string22(level) {
  if (level instanceof Rounded3) {
    return "rounded";
  } else {
    return "square";
  }
}

// build/dev/javascript/m3e/m3e/button_size.mjs
class ExtraSmall2 extends CustomType {
}
class Small3 extends CustomType {
}
class Medium5 extends CustomType {
}
class Large3 extends CustomType {
}
class ExtraLarge extends CustomType {
}
function to_string23(level) {
  if (level instanceof ExtraSmall2) {
    return "extra-small";
  } else if (level instanceof Small3) {
    return "small";
  } else if (level instanceof Medium5) {
    return "medium";
  } else if (level instanceof Large3) {
    return "large";
  } else {
    return "extra-large";
  }
}

// build/dev/javascript/m3e/m3e/button_variant.mjs
class Elevated2 extends CustomType {
}
class Filled3 extends CustomType {
}
class Tonal2 extends CustomType {
}
class Outlined4 extends CustomType {
}
class Text2 extends CustomType {
}
function to_string24(level) {
  if (level instanceof Elevated2) {
    return "elevated";
  } else if (level instanceof Filled3) {
    return "filled";
  } else if (level instanceof Tonal2) {
    return "tonal";
  } else if (level instanceof Outlined4) {
    return "outlined";
  } else {
    return "text";
  }
}

// build/dev/javascript/m3e/m3e/button.mjs
class Button3 extends CustomType {
  constructor(disabled, disabled_interactive, download, href2, name2, rel, selected2, shape, size4, target, toggle2, type_, value, variant2) {
    super();
    this.disabled = disabled;
    this.disabled_interactive = disabled_interactive;
    this.download = download;
    this.href = href2;
    this.name = name2;
    this.rel = rel;
    this.selected = selected2;
    this.shape = shape;
    this.size = size4;
    this.target = target;
    this.toggle = toggle2;
    this.type_ = type_;
    this.value = value;
    this.variant = variant2;
  }
}

class IsDisabled5 extends CustomType {
}
class IsNotDisabled5 extends CustomType {
}
class IsDisabledInteractive3 extends CustomType {
}
class IsNotDisabledInteractive3 extends CustomType {
}
class IsSelected3 extends CustomType {
}
class IsNotSelected3 extends CustomType {
}
class IsToggle2 extends CustomType {
}
class IsNotToggle2 extends CustomType {
}
class Icon4 extends CustomType {
}
class Selected2 extends CustomType {
}
class SelectedIcon2 extends CustomType {
}
class TrailingIcon extends CustomType {
}
class Config11 extends CustomType {
  constructor(disabled, disabled_interactive, download, href2, name2, rel, selected2, shape, size4, target, toggle2, type_, value, variant2) {
    super();
    this.disabled = disabled;
    this.disabled_interactive = disabled_interactive;
    this.download = download;
    this.href = href2;
    this.name = name2;
    this.rel = rel;
    this.selected = selected2;
    this.shape = shape;
    this.size = size4;
    this.target = target;
    this.toggle = toggle2;
    this.type_ = type_;
    this.value = value;
    this.variant = variant2;
  }
}
var default_download3 = /* @__PURE__ */ new None;
var default_href3 = "";
var default_name4 = "";
var default_rel3 = "";
var default_shape2 = /* @__PURE__ */ new Rounded3;
var default_size3 = /* @__PURE__ */ new Small3;
var default_target3 = /* @__PURE__ */ new None;
var default_type_3 = /* @__PURE__ */ new Button2;
var default_value3 = "";
var default_variant4 = /* @__PURE__ */ new Text2;
function default_config10() {
  return new Config11(new IsNotDisabled5, new IsNotDisabledInteractive3, new None, "", "", "", new IsNotSelected3, new Rounded3, new Small3, new None, new IsNotToggle2, new Button2, "", new Text2);
}
function from_config9(config2) {
  return new Button3(config2.disabled, config2.disabled_interactive, config2.download, config2.href, config2.name, config2.rel, config2.selected, config2.shape, config2.size, config2.target, config2.toggle, config2.type_, config2.value, config2.variant);
}
function new$14() {
  return from_config9(default_config10());
}
function disabled(record, disabled2) {
  return new Button3(disabled2, record.disabled_interactive, record.download, record.href, record.name, record.rel, record.selected, record.shape, record.size, record.target, record.toggle, record.type_, record.value, record.variant);
}
function disabled_interactive(record, disabled_interactive2) {
  return new Button3(record.disabled, disabled_interactive2, record.download, record.href, record.name, record.rel, record.selected, record.shape, record.size, record.target, record.toggle, record.type_, record.value, record.variant);
}
function href2(record, href3) {
  return new Button3(record.disabled, record.disabled_interactive, record.download, href3, record.name, record.rel, record.selected, record.shape, record.size, record.target, record.toggle, record.type_, record.value, record.variant);
}
function shape(record, shape2) {
  return new Button3(record.disabled, record.disabled_interactive, record.download, record.href, record.name, record.rel, record.selected, shape2, record.size, record.target, record.toggle, record.type_, record.value, record.variant);
}
function size4(record, size5) {
  return new Button3(record.disabled, record.disabled_interactive, record.download, record.href, record.name, record.rel, record.selected, record.shape, size5, record.target, record.toggle, record.type_, record.value, record.variant);
}
function target(record, target2) {
  return new Button3(record.disabled, record.disabled_interactive, record.download, record.href, record.name, record.rel, record.selected, record.shape, record.size, target2, record.toggle, record.type_, record.value, record.variant);
}
function toggle2(record, toggle3) {
  return new Button3(record.disabled, record.disabled_interactive, record.download, record.href, record.name, record.rel, record.selected, record.shape, record.size, record.target, toggle3, record.type_, record.value, record.variant);
}
function variant2(record, variant3) {
  return new Button3(record.disabled, record.disabled_interactive, record.download, record.href, record.name, record.rel, record.selected, record.shape, record.size, record.target, record.toggle, record.type_, record.value, variant3);
}
function slot7(s) {
  if (s instanceof Icon4) {
    return attribute2("slot", "icon");
  } else if (s instanceof Selected2) {
    return attribute2("slot", "selected");
  } else if (s instanceof SelectedIcon2) {
    return attribute2("slot", "selected-icon");
  } else {
    return attribute2("slot", "trailing-icon");
  }
}
function render11(model, attributes, children) {
  return element2("m3e-button", (() => {
    let _pipe = flatten(toList([
      toList([
        boolean("disabled", model.disabled instanceof IsDisabled5),
        boolean("disabled-interactive", model.disabled_interactive instanceof IsDisabledInteractive3),
        option(model.download, (_) => {
          return "download";
        }, identity2, default_download3),
        with_default("href", model.href, default_href3),
        with_default("name", model.name, default_name4),
        with_default("rel", model.rel, default_rel3),
        boolean("selected", model.selected instanceof IsSelected3),
        with_default("shape", to_string22(model.shape), to_string22(default_shape2)),
        with_default("size", to_string23(model.size), to_string23(default_size3)),
        option(model.target, (_) => {
          return "target";
        }, to_string16, default_target3),
        boolean("toggle", model.toggle instanceof IsToggle2),
        with_default("type", to_string11(model.type_), to_string11(default_type_3)),
        with_default("value", model.value, default_value3),
        with_default("variant", to_string24(model.variant), to_string24(default_variant4))
      ]),
      attributes
    ]));
    return filter(_pipe, (a) => {
      return !isEqual(a, none());
    });
  })(), children);
}

// build/dev/javascript/showcase/components/button_.mjs
function sizes2(_) {
  return div(toList([button_style()]), toList([
    (() => {
      let _pipe = new$14();
      let _pipe$1 = size4(_pipe, new ExtraSmall2);
      let _pipe$2 = variant2(_pipe$1, new Tonal2);
      return render11(_pipe$2, toList([]), toList([text2("Extra Small")]));
    })(),
    (() => {
      let _pipe = new$14();
      let _pipe$1 = size4(_pipe, new Small3);
      let _pipe$2 = variant2(_pipe$1, new Tonal2);
      return render11(_pipe$2, toList([]), toList([text2("Small")]));
    })(),
    (() => {
      let _pipe = new$14();
      let _pipe$1 = size4(_pipe, new Medium5);
      let _pipe$2 = variant2(_pipe$1, new Tonal2);
      return render11(_pipe$2, toList([]), toList([text2("Medium")]));
    })(),
    (() => {
      let _pipe = new$14();
      let _pipe$1 = size4(_pipe, new Large3);
      let _pipe$2 = variant2(_pipe$1, new Tonal2);
      return render11(_pipe$2, toList([]), toList([text2("Large")]));
    })(),
    (() => {
      let _pipe = new$14();
      let _pipe$1 = size4(_pipe, new ExtraLarge);
      let _pipe$2 = variant2(_pipe$1, new Tonal2);
      return render11(_pipe$2, toList([]), toList([text2("Extra Large")]));
    })()
  ]));
}
function button(model) {
  return page(toList([
    panel(model, "Variants", variant3),
    panel(model, "Shapes", shape2),
    panel(model, "Sizes", sizes2),
    panel(model, "Icons", icons),
    panel(model, "Toggling", toggling),
    panel(model, "Disabling", disabling),
    panel(model, "Links", links)
  ]));
}
function icons(_) {
  return div(toList([button_style()]), toList([
    (() => {
      let _pipe = new$14();
      let _pipe$1 = variant2(_pipe, new Tonal2);
      return render11(_pipe$1, toList([]), toList([
        (() => {
          let _pipe$2 = new$8();
          let _pipe$3 = name(_pipe$2, "send");
          return render4(_pipe$3, toList([slot7(new Icon4)]), toList([]));
        })(),
        text2("Send")
      ]));
    })(),
    (() => {
      let _pipe = new$14();
      let _pipe$1 = variant2(_pipe, new Tonal2);
      return render11(_pipe$1, toList([]), toList([
        (() => {
          let _pipe$2 = new$8();
          let _pipe$3 = name(_pipe$2, "open_in_new_window");
          return render4(_pipe$3, toList([slot7(new TrailingIcon)]), toList([]));
        })(),
        text2("Open")
      ]));
    })()
  ]));
}
function toggling(_) {
  return div(toList([button_style()]), toList([
    (() => {
      let _pipe = new$14();
      let _pipe$1 = toggle2(_pipe, new IsToggle2);
      let _pipe$2 = variant2(_pipe$1, new Elevated2);
      return render11(_pipe$2, toList([]), toList([text2("Elevated toggle")]));
    })(),
    (() => {
      let _pipe = new$14();
      let _pipe$1 = toggle2(_pipe, new IsToggle2);
      let _pipe$2 = variant2(_pipe$1, new Filled3);
      return render11(_pipe$2, toList([]), toList([text2("Filled toggle")]));
    })(),
    (() => {
      let _pipe = new$14();
      let _pipe$1 = toggle2(_pipe, new IsToggle2);
      let _pipe$2 = variant2(_pipe$1, new Tonal2);
      return render11(_pipe$2, toList([]), toList([text2("Tonal toggle")]));
    })(),
    (() => {
      let _pipe = new$14();
      let _pipe$1 = toggle2(_pipe, new IsToggle2);
      let _pipe$2 = variant2(_pipe$1, new Outlined4);
      return render11(_pipe$2, toList([]), toList([text2("Outlined toggle")]));
    })(),
    (() => {
      let _pipe = new$14();
      let _pipe$1 = toggle2(_pipe, new IsToggle2);
      let _pipe$2 = variant2(_pipe$1, new Tonal2);
      return render11(_pipe$2, toList([]), toList([
        (() => {
          let _pipe$3 = new$8();
          let _pipe$4 = name(_pipe$3, "play_arrow");
          return render4(_pipe$4, toList([slot7(new Icon4)]), toList([text2("Open")]));
        })(),
        (() => {
          let _pipe$3 = new$8();
          let _pipe$4 = name(_pipe$3, "stop");
          return render4(_pipe$4, toList([slot7(new SelectedIcon2)]), toList([text2("Open")]));
        })(),
        text2("Start"),
        span(toList([slot7(new Selected2)]), toList([text2("Stop")]))
      ]));
    })()
  ]));
}
function disabling(_) {
  return div(toList([button_style()]), toList([
    (() => {
      let _pipe = new$14();
      let _pipe$1 = disabled(_pipe, new IsDisabled5);
      let _pipe$2 = variant2(_pipe$1, new Filled3);
      return render11(_pipe$2, toList([]), toList([text2("Disabled")]));
    })(),
    (() => {
      let _pipe = new$14();
      let _pipe$1 = disabled_interactive(_pipe, new IsDisabledInteractive3);
      let _pipe$2 = variant2(_pipe$1, new Filled3);
      return render11(_pipe$2, toList([]), toList([text2("Disabled interactive")]));
    })()
  ]));
}
function links(_) {
  return div(toList([button_style()]), toList([
    (() => {
      let _pipe = new$14();
      let _pipe$1 = href2(_pipe, "https://google.com");
      let _pipe$2 = target(_pipe$1, new Some(new Blank));
      let _pipe$3 = variant2(_pipe$2, new Tonal2);
      return render11(_pipe$3, toList([]), toList([
        text2("Google"),
        (() => {
          let _pipe$4 = new$8();
          let _pipe$5 = name(_pipe$4, "open_in_new_window");
          return render4(_pipe$5, toList([slot7(new TrailingIcon)]), toList([]));
        })()
      ]));
    })()
  ]));
}
function shape2(_) {
  return div(toList([button_style()]), toList([
    (() => {
      let _pipe = new$14();
      let _pipe$1 = shape(_pipe, new Rounded3);
      let _pipe$2 = variant2(_pipe$1, new Filled3);
      return render11(_pipe$2, toList([]), toList([text2("Rounded Filled")]));
    })(),
    (() => {
      let _pipe = new$14();
      let _pipe$1 = shape(_pipe, new Square);
      let _pipe$2 = variant2(_pipe$1, new Filled3);
      return render11(_pipe$2, toList([]), toList([text2("Square Filled")]));
    })()
  ]));
}
function variant3(_) {
  return div(toList([button_style()]), toList([
    (() => {
      let _pipe = new$14();
      let _pipe$1 = variant2(_pipe, new Elevated2);
      return render11(_pipe$1, toList([]), toList([text2("Elevated")]));
    })(),
    (() => {
      let _pipe = new$14();
      let _pipe$1 = variant2(_pipe, new Filled3);
      return render11(_pipe$1, toList([]), toList([text2("Filled")]));
    })(),
    (() => {
      let _pipe = new$14();
      let _pipe$1 = variant2(_pipe, new Tonal2);
      return render11(_pipe$1, toList([]), toList([text2("Tonal")]));
    })(),
    (() => {
      let _pipe = new$14();
      let _pipe$1 = variant2(_pipe, new Outlined4);
      return render11(_pipe$1, toList([]), toList([text2("Outlined")]));
    })(),
    (() => {
      let _pipe = new$14();
      let _pipe$1 = variant2(_pipe, new Text2);
      return render11(_pipe$1, toList([]), toList([text2("Text")]));
    })()
  ]));
}
function package$2() {
  return new Package(new Button, "Button", button, new ButtonSelected);
}

// build/dev/javascript/m3e/m3e/calendar_view.mjs
class Month extends CustomType {
}
class Year extends CustomType {
}
class MultiYear extends CustomType {
}
function to_string25(level) {
  if (level instanceof Month) {
    return "month";
  } else if (level instanceof Year) {
    return "year";
  } else {
    return "multi-year";
  }
}

// build/dev/javascript/m3e/m3e/range.mjs
function range(i, min2, max2) {
  let $ = i >= min2 && i <= max2;
  if ($) {
    return new Ok(i);
  } else {
    return new Error(to_string(i) + " is out of range >=" + to_string(min2) + " and <=" + to_string(max2));
  }
}

// build/dev/javascript/m3e/m3e/hour.mjs
class Hour extends CustomType {
  constructor(hour) {
    super();
    this.hour = hour;
  }
}
function new$15(hour) {
  return try$((() => {
    let _pipe = range(hour, 0, 23);
    return replace_error(_pipe, to_string(hour) + " is not a valid hour");
  })(), (h) => {
    return new Ok(new Hour(h));
  });
}
function hour(h) {
  return h.hour;
}

// build/dev/javascript/m3e/m3e/minute.mjs
class Minute extends CustomType {
  constructor(minute) {
    super();
    this.minute = minute;
  }
}
function new$16(minute) {
  return try$((() => {
    let _pipe = range(minute, 0, 59);
    return replace_error(_pipe, to_string(minute) + " is not a valid minute");
  })(), (m) => {
    return new Ok(new Minute(m));
  });
}
function minute(m) {
  return m.minute;
}

// build/dev/javascript/m3e/m3e/second.mjs
class Second extends CustomType {
  constructor(second) {
    super();
    this.second = second;
  }
}
function new$17(second) {
  return try$((() => {
    let _pipe = range(second, 0, 59);
    return replace_error(_pipe, to_string(second) + " is not a valid second");
  })(), (s) => {
    return new Ok(new Second(s));
  });
}
function second(s) {
  return s.second;
}

// build/dev/javascript/m3e/m3e/time.mjs
class Time extends CustomType {
  constructor(hour2, minute2, second2) {
    super();
    this.hour = hour2;
    this.minute = minute2;
    this.second = second2;
  }
}
function less_than2(time1, time2) {
  let c1 = hour(time1.hour) < hour(time2.hour);
  let c2 = hour(time1.hour) === hour(time2.hour) && minute(time1.minute) < minute(time2.minute);
  let c3 = hour(time1.hour) === hour(time2.hour) && minute(time1.minute) === minute(time2.minute) && second(time1.second) < second(time2.second);
  return c1 || c2 || c3;
}
function to_hhmm(t) {
  return pad_start(to_string(hour(t.hour)), 2, "0") + ":" + pad_start(to_string(minute(t.minute)), 2, "0");
}
function to_string26(t) {
  return pad_start(to_string(hour(t.hour)), 2, "0") + ":" + pad_start(to_string(minute(t.minute)), 2, "0") + ":" + pad_start(to_string(second(t.second)), 2, "0");
}
function full_time_(h, m, s) {
  return try$((() => {
    let _pipe = parse_int(h);
    return replace_error(_pipe, h + " is an invalid hour");
  })(), (hh) => {
    return try$(new$15(hh), (hour2) => {
      return try$((() => {
        let _pipe = parse_int(m);
        return replace_error(_pipe, m + " is an invalid minute");
      })(), (mm) => {
        return try$(new$16(mm), (minutes) => {
          return try$((() => {
            let _pipe = parse_int(s);
            return replace_error(_pipe, s + " is an invalid second");
          })(), (ss) => {
            return try$(new$17(ss), (seconds) => {
              return new Ok([hour2, minutes, seconds]);
            });
          });
        });
      });
    });
  });
}
function time_(input2) {
  let $ = split2(input2, ":");
  if ($ instanceof Empty) {
    return new Error(input2 + " is an invalid time string, must be hh:mm:ss or hh:mm");
  } else {
    let $1 = $.tail;
    if ($1 instanceof Empty) {
      return new Error(input2 + " is an invalid time string, must be hh:mm:ss or hh:mm");
    } else {
      let $2 = $1.tail;
      if ($2 instanceof Empty) {
        let h = $.head;
        let m = $1.head;
        return full_time_(h, m, "00");
      } else {
        let $3 = $2.tail;
        if ($3 instanceof Empty) {
          let h = $.head;
          let m = $1.head;
          let s = $2.head;
          return full_time_(h, m, s);
        } else {
          return new Error(input2 + " is an invalid time string, must be hh:mm:ss or hh:mm");
        }
      }
    }
  }
}
function from_string(input2) {
  return try$(time_(input2), (_use0) => {
    let hour2;
    let minute2;
    let second2;
    hour2 = _use0[0];
    minute2 = _use0[1];
    second2 = _use0[2];
    return new Ok(new Time(hour2, minute2, second2));
  });
}

// build/dev/javascript/m3e/m3e/timezone.mjs
class Plus extends CustomType {
}
class Minus extends CustomType {
}
class Zulu extends CustomType {
}

class Offset extends CustomType {
  constructor(sign, amount) {
    super();
    this.sign = sign;
    this.amount = amount;
  }
}
function zulu() {
  return new Zulu;
}
function sign_to_string_(sign) {
  if (sign instanceof Plus) {
    return "+";
  } else {
    return "-";
  }
}
function to_string27(tz) {
  if (tz instanceof Zulu) {
    return "Z";
  } else {
    let sign = tz.sign;
    let time = tz.amount;
    return sign_to_string_(sign) + to_hhmm(time);
  }
}
function validate_limit(t, limit_str, sign, err) {
  return try$((() => {
    let _pipe = from_string(limit_str);
    return replace_error(_pipe, "Invalid timezone offset limit");
  })(), (limit) => {
    return guard(!less_than2(t, limit), new Error(err), () => {
      return new Ok(new Offset(sign, t));
    });
  });
}
function offset_(sign, time) {
  if (sign instanceof Plus) {
    return validate_limit(time, "14:01", new Plus, "Positive timezone offset must be less than 14:00");
  } else {
    return validate_limit(time, "12:01", new Minus, "Negative timezone offset must be less than 12:00");
  }
}
function new$18(direction, time) {
  return try$(offset_(direction, time), (os) => {
    return new Ok(os);
  });
}
// build/dev/javascript/m3e/m3e/positive.mjs
function positive(i) {
  let $ = i > 0;
  if ($) {
    return new Ok(i);
  } else {
    return new Error(to_string(i) + " is not a positive integer");
  }
}

// build/dev/javascript/m3e/m3e/day.mjs
class Day2 extends CustomType {
  constructor(day, month_, year_) {
    super();
    this.day = day;
    this.month_ = month_;
    this.year_ = year_;
  }
}
var default$4 = /* @__PURE__ */ new Day2(1, 1, 1970);
function to_string28(d) {
  return pad_start(to_string(d.day), 2, "0");
}
function day_(dd, month, year) {
  return try$((() => {
    let _pipe = positive(dd);
    return map_error(_pipe, (_) => {
      return to_string(dd) + " is not a valid day";
    });
  })(), (day) => {
    return try$(range(month, 1, 12), (month2) => {
      return try$(positive(year), (year2) => {
        let is_leap = year2 % 4 === 0 && year2 % 100 !== 0 || year2 % 400 === 0;
        let _block;
        if (month2 === 4) {
          _block = day >= 1 && day <= 30;
        } else if (month2 === 6) {
          _block = day >= 1 && day <= 30;
        } else if (month2 === 9) {
          _block = day >= 1 && day <= 30;
        } else if (month2 === 11) {
          _block = day >= 1 && day <= 30;
        } else if (month2 === 2) {
          if (is_leap) {
            _block = day >= 1 && day <= 29;
          } else {
            _block = day >= 1 && day <= 28;
          }
        } else {
          _block = day >= 1 && day <= 31;
        }
        let day_ok = _block;
        if (day_ok) {
          return new Ok(day);
        } else {
          return new Error(to_string(dd) + " is not a valid day for month " + to_string(month2) + " in year " + to_string(year2));
        }
      });
    });
  });
}
function new$20(day, m, y) {
  return try$(day_(day, m, y), (d) => {
    return new Ok(new Day2(d, m, y));
  });
}

// build/dev/javascript/m3e/m3e/month.mjs
class Month3 extends CustomType {
  constructor(month) {
    super();
    this.month = month;
  }
}
var default$5 = /* @__PURE__ */ new Month3(1);
function new$21(month) {
  return try$(range(month, 1, 12), (m) => {
    return new Ok(new Month3(m));
  });
}
function to_string29(m) {
  return pad_start(to_string(m.month), 2, "0");
}

// build/dev/javascript/m3e/m3e/year.mjs
class Year3 extends CustomType {
  constructor(year) {
    super();
    this.year = year;
  }
}
var default$6 = /* @__PURE__ */ new Year3(1800);
function new$22(year) {
  return try$(range(year, 1800, 2500), (y) => {
    return new Ok(new Year3(y));
  });
}
function to_string30(y) {
  return to_string(y.year);
}

// build/dev/javascript/m3e/m3e/ymd.mjs
class Ymd extends CustomType {
  constructor(year2, month2, day) {
    super();
    this.year = year2;
    this.month = month2;
    this.day = day;
  }
}
var default$7 = /* @__PURE__ */ new Ymd(default$6, default$5, default$4);
function from_string3(input2) {
  let $ = split2(input2, "-");
  if ($ instanceof Empty) {
    return new Error(input2 + " is an invalid date string, must be yyyy-mm-dd");
  } else {
    let $1 = $.tail;
    if ($1 instanceof Empty) {
      return new Error(input2 + " is an invalid date string, must be yyyy-mm-dd");
    } else {
      let $2 = $1.tail;
      if ($2 instanceof Empty) {
        return new Error(input2 + " is an invalid date string, must be yyyy-mm-dd");
      } else {
        let $3 = $2.tail;
        if ($3 instanceof Empty) {
          let y = $.head;
          let m = $1.head;
          let d = $2.head;
          return try$((() => {
            let _pipe = parse_int(y);
            return replace_error(_pipe, y + " can't be parsed as a year");
          })(), (yr) => {
            return try$(new$22(yr), (year2) => {
              return try$((() => {
                let _pipe = parse_int(m);
                return replace_error(_pipe, m + " can't be parsed as a month");
              })(), (mon) => {
                return try$(new$21(mon), (month2) => {
                  return try$((() => {
                    let _pipe = parse_int(d);
                    return replace_error(_pipe, d + " can't be parsed as a day");
                  })(), (dy) => {
                    return try$(new$20(dy, mon, yr), (day) => {
                      return new Ok(new Ymd(year2, month2, day));
                    });
                  });
                });
              });
            });
          });
        } else {
          return new Error(input2 + " is an invalid date string, must be yyyy-mm-dd");
        }
      }
    }
  }
}
function to_string31(d) {
  return to_string30(d.year) + "-" + pad_start(to_string29(d.month), 2, "0") + "-" + pad_start(to_string28(d.day), 2, "0");
}

// build/dev/javascript/m3e/m3e/date.mjs
class Full extends CustomType {
  constructor(date2, time, timezone) {
    super();
    this.date = date2;
    this.time = time;
    this.timezone = timezone;
  }
}

class Date3 extends CustomType {
  constructor(date2) {
    super();
    this.date = date2;
  }
}

class DateTime extends CustomType {
  constructor(date2, time) {
    super();
    this.date = date2;
    this.time = time;
  }
}
var default$8 = /* @__PURE__ */ new Date3(default$7);
function to_string32(d) {
  if (d instanceof Full) {
    let date2 = d.date;
    let time = d.time;
    let tz = d.timezone;
    return to_string31(date2) + "T" + to_string26(time) + to_string27(tz);
  } else if (d instanceof Date3) {
    let date2 = d.date;
    return to_string31(date2);
  } else {
    let date2 = d.date;
    let time = d.time;
    return to_string31(date2) + "T" + to_string26(time);
  }
}
function date_time(date2, time) {
  return try$(from_string(time), (tim) => {
    return try$(from_string3(date2), (d) => {
      return new Ok(new DateTime(d, tim));
    });
  });
}
function date_time_tz(date2, time, offset, sign) {
  return try$(from_string(time), (tim) => {
    return try$(from_string3(date2), (d) => {
      return try$(from_string(offset), (tz_time) => {
        return try$(new$18(sign, tz_time), (tz) => {
          return new Ok(new Full(d, tim, tz));
        });
      });
    });
  });
}
function date_time_zulu(date2, time) {
  return try$(from_string(time), (t) => {
    return try$(from_string3(date2), (d) => {
      return new Ok(new Full(d, t, zulu()));
    });
  });
}
function full_not_zulu(date2, rest) {
  let $ = split2(rest, "+");
  let $1 = split2(rest, "-");
  if ($ instanceof Empty) {
    return new Error(rest + " is an invalid timezone offset, must be ±HH:mm");
  } else if ($1 instanceof Empty) {
    return new Error(rest + " is an invalid timezone offset, must be ±HH:mm");
  } else {
    let $2 = $.tail;
    if ($2 instanceof Empty) {
      let $3 = $1.tail;
      if ($3 instanceof Empty) {
        let a = $.head;
        return date_time(date2, a);
      } else {
        let $4 = $3.tail;
        if ($4 instanceof Empty) {
          let a = $1.head;
          let b = $3.head;
          return date_time_tz(date2, a, b, new Minus);
        } else {
          return new Error(rest + " is an invalid timezone offset, must be ±HH:mm");
        }
      }
    } else {
      let $3 = $1.tail;
      if ($3 instanceof Empty) {
        let $4 = $2.tail;
        if ($4 instanceof Empty) {
          let a = $.head;
          let b = $2.head;
          return date_time_tz(date2, a, b, new Plus);
        } else {
          return new Error(rest + " is an invalid timezone offset, must be ±HH:mm");
        }
      } else {
        return new Error(rest + " is an invalid timezone offset, must be ±HH:mm");
      }
    }
  }
}
function full(date2, rest) {
  let rest$1 = uppercase(rest);
  let $ = ends_with(rest$1, "Z");
  if ($) {
    return date_time_zulu(date2, drop_end(rest$1, 1));
  } else {
    return full_not_zulu(date2, rest$1);
  }
}
function from_string4(input2) {
  let input$1 = uppercase(input2);
  let $ = split2(input$1, "T");
  if ($ instanceof Empty) {
    return new Error(input$1 + " is an invalid date-time format, must be yyyy-MM-dd or yyyy-MM-ddTHH:mm:ss or yyyy-MM-ddTHH:mm:ssZ or yyyy-MM-ddTHH:mm:ss±HH:mm");
  } else {
    let $1 = $.tail;
    if ($1 instanceof Empty) {
      let date2 = $.head;
      return try$(from_string3(date2), (d) => {
        return new Ok(new Date3(d));
      });
    } else {
      let $2 = $1.tail;
      if ($2 instanceof Empty) {
        let date2 = $.head;
        let rest = $1.head;
        return full(date2, rest);
      } else {
        return new Error(input$1 + " is an invalid date-time format, must be yyyy-MM-dd or yyyy-MM-ddTHH:mm:ss or yyyy-MM-ddTHH:mm:ssZ or yyyy-MM-ddTHH:mm:ss±HH:mm");
      }
    }
  }
}

// build/dev/javascript/m3e/m3e/calendar.mjs
class Calendar2 extends CustomType {
  constructor(date2, max_date, min_date, range_end, range_start, start_at, start_view, previous_month_label, next_month_label, previous_year_label, next_year_label, previous_multi_year_label, next_multi_year_label) {
    super();
    this.date = date2;
    this.max_date = max_date;
    this.min_date = min_date;
    this.range_end = range_end;
    this.range_start = range_start;
    this.start_at = start_at;
    this.start_view = start_view;
    this.previous_month_label = previous_month_label;
    this.next_month_label = next_month_label;
    this.previous_year_label = previous_year_label;
    this.next_year_label = next_year_label;
    this.previous_multi_year_label = previous_multi_year_label;
    this.next_multi_year_label = next_multi_year_label;
  }
}
class Config12 extends CustomType {
  constructor(date2, max_date, min_date, range_end, range_start, start_at, start_view, previous_month_label, next_month_label, previous_year_label, next_year_label, previous_multi_year_label, next_multi_year_label) {
    super();
    this.date = date2;
    this.max_date = max_date;
    this.min_date = min_date;
    this.range_end = range_end;
    this.range_start = range_start;
    this.start_at = start_at;
    this.start_view = start_view;
    this.previous_month_label = previous_month_label;
    this.next_month_label = next_month_label;
    this.previous_year_label = previous_year_label;
    this.next_year_label = next_year_label;
    this.previous_multi_year_label = previous_multi_year_label;
    this.next_multi_year_label = next_multi_year_label;
  }
}
var default_date = /* @__PURE__ */ new None;
var default_max_date = /* @__PURE__ */ new None;
var default_min_date = /* @__PURE__ */ new None;
var default_range_end = /* @__PURE__ */ new None;
var default_range_start = /* @__PURE__ */ new None;
var default_start_at = /* @__PURE__ */ new None;
var default_start_view = /* @__PURE__ */ new Month;
var default_previous_month_label = "Previous month";
var default_next_month_label = "Next month";
var default_previous_year_label = "Previous year";
var default_next_year_label = "Next year";
var default_previous_multi_year_label = "Previous 24 years";
var default_next_multi_year_label = "Next 24 years";
function default_config11() {
  return new Config12(new None, new None, new None, new None, new None, new None, new Month, "Previous month", "Next month", "Previous year", "Next year", "Previous 24 years", "Next 24 years");
}
function from_config10(config2) {
  return new Calendar2(config2.date, config2.max_date, config2.min_date, config2.range_end, config2.range_start, config2.start_at, config2.start_view, config2.previous_month_label, config2.next_month_label, config2.previous_year_label, config2.next_year_label, config2.previous_multi_year_label, config2.next_multi_year_label);
}
function new$23() {
  return from_config10(default_config11());
}
function date2(record, date3) {
  return new Calendar2(date3, record.max_date, record.min_date, record.range_end, record.range_start, record.start_at, record.start_view, record.previous_month_label, record.next_month_label, record.previous_year_label, record.next_year_label, record.previous_multi_year_label, record.next_multi_year_label);
}
function max_date(record, max_date2) {
  return new Calendar2(record.date, max_date2, record.min_date, record.range_end, record.range_start, record.start_at, record.start_view, record.previous_month_label, record.next_month_label, record.previous_year_label, record.next_year_label, record.previous_multi_year_label, record.next_multi_year_label);
}
function min_date(record, min_date2) {
  return new Calendar2(record.date, record.max_date, min_date2, record.range_end, record.range_start, record.start_at, record.start_view, record.previous_month_label, record.next_month_label, record.previous_year_label, record.next_year_label, record.previous_multi_year_label, record.next_multi_year_label);
}
function range_end(record, range_end2) {
  return new Calendar2(record.date, record.max_date, record.min_date, range_end2, record.range_start, record.start_at, record.start_view, record.previous_month_label, record.next_month_label, record.previous_year_label, record.next_year_label, record.previous_multi_year_label, record.next_multi_year_label);
}
function range_start(record, range_start2) {
  return new Calendar2(record.date, record.max_date, record.min_date, record.range_end, range_start2, record.start_at, record.start_view, record.previous_month_label, record.next_month_label, record.previous_year_label, record.next_year_label, record.previous_multi_year_label, record.next_multi_year_label);
}
function start_at(record, start_at2) {
  return new Calendar2(record.date, record.max_date, record.min_date, record.range_end, record.range_start, start_at2, record.start_view, record.previous_month_label, record.next_month_label, record.previous_year_label, record.next_year_label, record.previous_multi_year_label, record.next_multi_year_label);
}
function start_view(record, start_view2) {
  return new Calendar2(record.date, record.max_date, record.min_date, record.range_end, record.range_start, record.start_at, start_view2, record.previous_month_label, record.next_month_label, record.previous_year_label, record.next_year_label, record.previous_multi_year_label, record.next_multi_year_label);
}
function render12(model, attributes, children) {
  return element2("m3e-calendar", (() => {
    let _pipe = flatten(toList([
      toList([
        option(model.date, (_) => {
          return "date";
        }, to_string32, default_date),
        option(model.max_date, (_) => {
          return "max-date";
        }, to_string32, default_max_date),
        option(model.min_date, (_) => {
          return "min-date";
        }, to_string32, default_min_date),
        option(model.range_end, (_) => {
          return "range-end";
        }, to_string32, default_range_end),
        option(model.range_start, (_) => {
          return "range-start";
        }, to_string32, default_range_start),
        option(model.start_at, (_) => {
          return "start-at";
        }, to_string32, default_start_at),
        with_default("start-view", to_string25(model.start_view), to_string25(default_start_view)),
        with_default("previous-month-label", model.previous_month_label, default_previous_month_label),
        with_default("next-month-label", model.next_month_label, default_next_month_label),
        with_default("previous-year-label", model.previous_year_label, default_previous_year_label),
        with_default("next-year-label", model.next_year_label, default_next_year_label),
        with_default("previous-multi-year-label", model.previous_multi_year_label, default_previous_multi_year_label),
        with_default("next-multi-year-label", model.next_multi_year_label, default_next_multi_year_label)
      ]),
      attributes
    ]));
    return filter(_pipe, (a) => {
      return !isEqual(a, none());
    });
  })(), children);
}

// build/dev/javascript/showcase/components/calendar_.mjs
function date_selection(model) {
  let id2 = "calendar1";
  let _block;
  let _pipe = from_string4(model.date_str);
  _block = unwrap(_pipe, default$8);
  let the_date = _block;
  return div(toList([flex_column()]), toList([
    (() => {
      let _pipe$1 = new$23();
      let _pipe$2 = date2(_pipe$1, new Some(the_date));
      return render12(_pipe$2, toList([
        on("change", success(new CalendarDateSelected(id2))),
        id(id2)
      ]), toList([]));
    })(),
    text2("Selected date: "),
    text2(model.date_str)
  ]));
}
function calendar(model) {
  return page(toList([
    panel(model, "Date selection", date_selection),
    panel(model, "Start at", start_at2),
    panel(model, "Start view", start_view2),
    panel(model, "Date ranges", date_ranges),
    panel(model, "Min and max", min_max),
    panel(model, "Blackout dates", blackout)
  ]));
}
function start_at2(_) {
  let id2 = "calendar2";
  let _block;
  let _pipe = from_string4("2026-01-01");
  _block = unwrap(_pipe, default$8);
  let the_date = _block;
  return div(toList([flex_column()]), toList([
    (() => {
      let _pipe$1 = new$23();
      let _pipe$2 = start_at(_pipe$1, new Some(the_date));
      return render12(_pipe$2, toList([
        on("change", success(new CalendarDateSelected(id2))),
        id(id2)
      ]), toList([]));
    })()
  ]));
}
function start_view2(_) {
  let id2 = "calendar3";
  return div(toList([flex_column()]), toList([
    (() => {
      let _pipe = new$23();
      let _pipe$1 = start_view(_pipe, new MultiYear);
      return render12(_pipe$1, toList([
        on("change", success(new CalendarDateSelected(id2))),
        id(id2)
      ]), toList([]));
    })()
  ]));
}
function date_ranges(_) {
  let id2 = "calendar4";
  let _block;
  let _pipe = from_string4("2026-01-05");
  _block = unwrap(_pipe, default$8);
  let range_start2 = _block;
  let _block$1;
  let _pipe$1 = from_string4("2026-01-15");
  _block$1 = unwrap(_pipe$1, default$8);
  let range_end2 = _block$1;
  let _block$2;
  let _pipe$2 = from_string4("2026-01-01");
  _block$2 = unwrap(_pipe$2, default$8);
  let start_at$1 = _block$2;
  return div(toList([flex_column()]), toList([
    (() => {
      let _pipe$3 = new$23();
      let _pipe$4 = range_start(_pipe$3, new Some(range_start2));
      let _pipe$5 = range_end(_pipe$4, new Some(range_end2));
      let _pipe$6 = start_at(_pipe$5, new Some(start_at$1));
      return render12(_pipe$6, toList([
        on("change", success(new CalendarDateSelected(id2))),
        id(id2)
      ]), toList([]));
    })()
  ]));
}
function min_max(_) {
  let id2 = "calendar5";
  let _block;
  let _pipe = from_string4("2026-01-01");
  _block = unwrap(_pipe, default$8);
  let min_date2 = _block;
  let _block$1;
  let _pipe$1 = from_string4("2026-04-30");
  _block$1 = unwrap(_pipe$1, default$8);
  let max_date2 = _block$1;
  let _block$2;
  let _pipe$2 = from_string4("2026-04-01");
  _block$2 = unwrap(_pipe$2, default$8);
  let start_at$1 = _block$2;
  return div(toList([flex_column()]), toList([
    (() => {
      let _pipe$3 = new$23();
      let _pipe$4 = min_date(_pipe$3, new Some(min_date2));
      let _pipe$5 = max_date(_pipe$4, new Some(max_date2));
      let _pipe$6 = start_at(_pipe$5, new Some(start_at$1));
      return render12(_pipe$6, toList([
        on("change", success(new CalendarDateSelected(id2))),
        id(id2)
      ]), toList([]));
    })()
  ]));
}
function blackout(_) {
  let id2 = "calendar6";
  let $ = is_blackout_date("2026-01-01");
  return div(toList([flex_column()]), toList([
    (() => {
      let _pipe = new$23();
      return render12(_pipe, toList([id(id2)]), toList([]));
    })()
  ]));
}
function package$3() {
  return new Package(new Calendar, "Calendar", calendar, new CalendarSelected("#calendar6"));
}

// build/dev/javascript/m3e/m3e/datepicker_variant.mjs
class Docked extends CustomType {
}
class Modal extends CustomType {
}
class Auto4 extends CustomType {
}
function to_string33(level) {
  if (level instanceof Docked) {
    return "docked";
  } else if (level instanceof Modal) {
    return "modal";
  } else {
    return "auto";
  }
}

// build/dev/javascript/m3e/m3e/datepicker.mjs
class Datepicker2 extends CustomType {
  constructor(variant4, clearable, date3, max_date2, min_date2, range_end2, range_start2, start_at3, start_view3, previous_month_label, next_month_label, previous_year_label, next_year_label, previous_multi_year_label, next_multi_year_label, clear_label, confirm_label, dismiss_label, label2) {
    super();
    this.variant = variant4;
    this.clearable = clearable;
    this.date = date3;
    this.max_date = max_date2;
    this.min_date = min_date2;
    this.range_end = range_end2;
    this.range_start = range_start2;
    this.start_at = start_at3;
    this.start_view = start_view3;
    this.previous_month_label = previous_month_label;
    this.next_month_label = next_month_label;
    this.previous_year_label = previous_year_label;
    this.next_year_label = next_year_label;
    this.previous_multi_year_label = previous_multi_year_label;
    this.next_multi_year_label = next_multi_year_label;
    this.clear_label = clear_label;
    this.confirm_label = confirm_label;
    this.dismiss_label = dismiss_label;
    this.label = label2;
  }
}

class IsClearable extends CustomType {
}
class IsNotClearable extends CustomType {
}
class Config13 extends CustomType {
  constructor(variant4, clearable, date3, max_date2, min_date2, range_end2, range_start2, start_at3, start_view3, previous_month_label, next_month_label, previous_year_label, next_year_label, previous_multi_year_label, next_multi_year_label, clear_label, confirm_label, dismiss_label, label2) {
    super();
    this.variant = variant4;
    this.clearable = clearable;
    this.date = date3;
    this.max_date = max_date2;
    this.min_date = min_date2;
    this.range_end = range_end2;
    this.range_start = range_start2;
    this.start_at = start_at3;
    this.start_view = start_view3;
    this.previous_month_label = previous_month_label;
    this.next_month_label = next_month_label;
    this.previous_year_label = previous_year_label;
    this.next_year_label = next_year_label;
    this.previous_multi_year_label = previous_multi_year_label;
    this.next_multi_year_label = next_multi_year_label;
    this.clear_label = clear_label;
    this.confirm_label = confirm_label;
    this.dismiss_label = dismiss_label;
    this.label = label2;
  }
}
var default_variant5 = /* @__PURE__ */ new Docked;
var default_date2 = /* @__PURE__ */ new None;
var default_max_date2 = /* @__PURE__ */ new None;
var default_min_date2 = /* @__PURE__ */ new None;
var default_range_end2 = /* @__PURE__ */ new None;
var default_range_start2 = /* @__PURE__ */ new None;
var default_start_at2 = /* @__PURE__ */ new None;
var default_start_view2 = /* @__PURE__ */ new Month;
var default_previous_month_label2 = "Previous month";
var default_next_month_label2 = "Next month";
var default_previous_year_label2 = "Previous year";
var default_next_year_label2 = "Next year";
var default_previous_multi_year_label2 = "Previous 24 years";
var default_next_multi_year_label2 = "Next 24 years";
var default_clear_label = "Clear";
var default_confirm_label = "OK";
var default_dismiss_label = "Cancel";
var default_label = "Select date";
function default_config12() {
  return new Config13(new Docked, new IsNotClearable, new None, new None, new None, new None, new None, new None, new Month, "Previous month", "Next month", "Previous year", "Next year", "Previous 24 years", "Next 24 years", "Clear", "OK", "Cancel", "Select date");
}
function from_config11(config2) {
  return new Datepicker2(config2.variant, config2.clearable, config2.date, config2.max_date, config2.min_date, config2.range_end, config2.range_start, config2.start_at, config2.start_view, config2.previous_month_label, config2.next_month_label, config2.previous_year_label, config2.next_year_label, config2.previous_multi_year_label, config2.next_multi_year_label, config2.clear_label, config2.confirm_label, config2.dismiss_label, config2.label);
}
function new$24() {
  return from_config11(default_config12());
}
function variant4(record, variant5) {
  return new Datepicker2(variant5, record.clearable, record.date, record.max_date, record.min_date, record.range_end, record.range_start, record.start_at, record.start_view, record.previous_month_label, record.next_month_label, record.previous_year_label, record.next_year_label, record.previous_multi_year_label, record.next_multi_year_label, record.clear_label, record.confirm_label, record.dismiss_label, record.label);
}
function render13(model, attributes, children) {
  return element2("m3e-datepicker", (() => {
    let _pipe = flatten(toList([
      toList([
        with_default("variant", to_string33(model.variant), to_string33(default_variant5)),
        boolean("clearable", model.clearable instanceof IsClearable),
        option(model.date, (_) => {
          return "date";
        }, to_string32, default_date2),
        option(model.max_date, (_) => {
          return "max-date";
        }, to_string32, default_max_date2),
        option(model.min_date, (_) => {
          return "min-date";
        }, to_string32, default_min_date2),
        option(model.range_end, (_) => {
          return "range-end";
        }, to_string32, default_range_end2),
        option(model.range_start, (_) => {
          return "range-start";
        }, to_string32, default_range_start2),
        option(model.start_at, (_) => {
          return "start-at";
        }, to_string32, default_start_at2),
        with_default("start-view", to_string25(model.start_view), to_string25(default_start_view2)),
        with_default("previous-month-label", model.previous_month_label, default_previous_month_label2),
        with_default("next-month-label", model.next_month_label, default_next_month_label2),
        with_default("previous-year-label", model.previous_year_label, default_previous_year_label2),
        with_default("next-year-label", model.next_year_label, default_next_year_label2),
        with_default("previous-multi-year-label", model.previous_multi_year_label, default_previous_multi_year_label2),
        with_default("next-multi-year-label", model.next_multi_year_label, default_next_multi_year_label2),
        with_default("clear-label", model.clear_label, default_clear_label),
        with_default("confirm-label", model.confirm_label, default_confirm_label),
        with_default("dismiss-label", model.dismiss_label, default_dismiss_label),
        with_default("label", model.label, default_label)
      ]),
      attributes
    ]));
    return filter(_pipe, (a) => {
      return !isEqual(a, none());
    });
  })(), children);
}

// build/dev/javascript/m3e/m3e/datepicker_toggle.mjs
class DatepickerToggle extends CustomType {
  constructor(for$4) {
    super();
    this.for = for$4;
  }
}
var default_for4 = /* @__PURE__ */ new None;
function new$25(for$4) {
  return new DatepickerToggle(for$4);
}
function render14(model, attributes, children) {
  return element2("m3e-datepicker-toggle", (() => {
    let _pipe = flatten(toList([
      toList([
        option(model.for, (_) => {
          return "for";
        }, identity2, default_for4)
      ]),
      attributes
    ]));
    return filter(_pipe, (a) => {
      return !isEqual(a, none());
    });
  })(), children);
}

// build/dev/javascript/m3e/m3e/float_label_type.mjs
class Always extends CustomType {
}
class Auto5 extends CustomType {
}
function to_string34(level) {
  if (level instanceof Always) {
    return "always";
  } else {
    return "auto";
  }
}

// build/dev/javascript/m3e/m3e/form_field_variant.mjs
class Filled4 extends CustomType {
}
class Outlined5 extends CustomType {
}
function to_string35(level) {
  if (level instanceof Filled4) {
    return "filled";
  } else {
    return "outlined";
  }
}

// build/dev/javascript/m3e/m3e/hide_subscript_type.mjs
class Always2 extends CustomType {
}
class Auto6 extends CustomType {
}
function to_string36(level) {
  if (level instanceof Always2) {
    return "always";
  } else if (level instanceof Auto6) {
    return "auto";
  } else {
    return "never";
  }
}

// build/dev/javascript/m3e/m3e/form_field.mjs
class FormField extends CustomType {
  constructor(float_label, hide_required_marker, hide_subscript, variant5) {
    super();
    this.float_label = float_label;
    this.hide_required_marker = hide_required_marker;
    this.hide_subscript = hide_subscript;
    this.variant = variant5;
  }
}

class IsHideRequiredMarker extends CustomType {
}
class IsNotHideRequiredMarker extends CustomType {
}
class Prefix extends CustomType {
}
class PrefixText extends CustomType {
}
class Suffix extends CustomType {
}
class SuffixText extends CustomType {
}
class Hint extends CustomType {
}
class Config14 extends CustomType {
  constructor(float_label, hide_required_marker, hide_subscript, variant5) {
    super();
    this.float_label = float_label;
    this.hide_required_marker = hide_required_marker;
    this.hide_subscript = hide_subscript;
    this.variant = variant5;
  }
}
var default_float_label = /* @__PURE__ */ new Auto5;
var default_hide_subscript = /* @__PURE__ */ new Auto6;
var default_variant6 = /* @__PURE__ */ new Outlined5;
function default_config13() {
  return new Config14(new Auto5, new IsNotHideRequiredMarker, new Auto6, new Outlined5);
}
function from_config12(config2) {
  return new FormField(config2.float_label, config2.hide_required_marker, config2.hide_subscript, config2.variant);
}
function new$26() {
  return from_config12(default_config13());
}
function variant5(record, variant6) {
  return new FormField(record.float_label, record.hide_required_marker, record.hide_subscript, variant6);
}
function slot8(s) {
  if (s instanceof Prefix) {
    return attribute2("slot", "prefix");
  } else if (s instanceof PrefixText) {
    return attribute2("slot", "prefix-text");
  } else if (s instanceof Suffix) {
    return attribute2("slot", "suffix");
  } else if (s instanceof SuffixText) {
    return attribute2("slot", "suffix-text");
  } else if (s instanceof Hint) {
    return attribute2("slot", "hint");
  } else {
    return attribute2("slot", "error");
  }
}
function render15(model, attributes, children) {
  return element2("m3e-form-field", (() => {
    let _pipe = flatten(toList([
      toList([
        with_default("float-label", to_string34(model.float_label), to_string34(default_float_label)),
        boolean("hide-required-marker", model.hide_required_marker instanceof IsHideRequiredMarker),
        with_default("hide-subscript", to_string36(model.hide_subscript), to_string36(default_hide_subscript)),
        with_default("variant", to_string35(model.variant), to_string35(default_variant6))
      ]),
      attributes
    ]));
    return filter(_pipe, (a) => {
      return !isEqual(a, none());
    });
  })(), children);
}

// build/dev/javascript/showcase/components/datepicker_.mjs
function basic_usage(_) {
  return div(toList([]), toList([
    (() => {
      let _pipe = new$26();
      let _pipe$1 = variant5(_pipe, new Outlined5);
      return render15(_pipe$1, toList([]), toList([
        label(toList([for$("fld1")]), toList([text2("Date Field")])),
        input(toList([id("fld1"), autocomplete("off")])),
        (() => {
          let _pipe$2 = new$9();
          return render5(_pipe$2, toList([slot8(new Suffix)]), toList([
            (() => {
              let _pipe$3 = new$8();
              let _pipe$4 = name(_pipe$3, "calendar_today");
              return render4(_pipe$4, toList([]), toList([]));
            })(),
            (() => {
              let _pipe$3 = new$25(new Some("datepicker1"));
              return render14(_pipe$3, toList([]), toList([]));
            })()
          ]));
        })(),
        span(toList([slot8(new Hint)]), toList([text2("MM/DD/YYYY")]))
      ]));
    })(),
    (() => {
      let _pipe = new$24();
      let _pipe$1 = variant4(_pipe, new Auto4);
      return render13(_pipe$1, toList([id("datepicker1")]), toList([]));
    })()
  ]));
}
function datepicker(model) {
  return page(toList([panel(model, "Basic Usage", basic_usage)]));
}
function package$4() {
  return new Package(new Datepicker, "Datepicker", datepicker, new DatepickerSelected("#datepicker1", "#fld1"));
}

// build/dev/javascript/showcase/components/home.mjs
function home(_) {
  return div(toList([]), toList([
    (() => {
      let _pipe = new$14();
      let _pipe$1 = variant2(_pipe, new Outlined4);
      return render11(_pipe$1, toList([on_click(new HomeSelected)]), toList([text2("Home")]));
    })()
  ]));
}

// build/dev/javascript/showcase/components/icon_.mjs
function basic(_) {
  return div(toList([]), toList([
    (() => {
      let _pipe = new$8();
      let _pipe$1 = name(_pipe, "home");
      return render4(_pipe$1, toList([]), toList([]));
    })()
  ]));
}
function icon(model) {
  return page(toList([
    panel(model, "Basic", basic),
    panel(model, "Appearance", appearance)
  ]));
}
function appearance(_) {
  return div(toList([icon_style()]), toList([
    (() => {
      let _pipe = new$8();
      let _pipe$1 = name(_pipe, "home");
      let _pipe$2 = variant(_pipe$1, new Outlined);
      return render4(_pipe$2, toList([]), toList([]));
    })(),
    label(toList([]), toList([text2("Outlined")])),
    (() => {
      let _pipe = new$8();
      let _pipe$1 = name(_pipe, "lock");
      let _pipe$2 = variant(_pipe$1, new Rounded);
      let _pipe$3 = filled(_pipe$2, new IsFilled);
      return render4(_pipe$3, toList([]), toList([]));
    })(),
    label(toList([]), toList([text2("Rounded")])),
    (() => {
      let _pipe = new$8();
      let _pipe$1 = name(_pipe, "lock");
      let _pipe$2 = variant(_pipe$1, new Sharp);
      let _pipe$3 = filled(_pipe$2, new IsFilled);
      return render4(_pipe$3, toList([]), toList([]));
    })(),
    label(toList([]), toList([text2("Sharp")]))
  ]));
}
function package$5() {
  return new Package(new Icon, "Icon", icon, new IconPageSelected);
}

// build/dev/javascript/m3e/m3e/switch_icons.mjs
class None2 extends CustomType {
}
class Selected3 extends CustomType {
}
class Both extends CustomType {
}
function to_string37(level) {
  if (level instanceof None2) {
    return "none";
  } else if (level instanceof Selected3) {
    return "selected";
  } else {
    return "both";
  }
}

// build/dev/javascript/m3e/m3e/switch.mjs
class Switch2 extends CustomType {
  constructor(checked, disabled2, icons2, name2, value) {
    super();
    this.checked = checked;
    this.disabled = disabled2;
    this.icons = icons2;
    this.name = name2;
    this.value = value;
  }
}

class IsChecked extends CustomType {
}
class IsNotChecked extends CustomType {
}
class IsDisabled6 extends CustomType {
}
class IsNotDisabled6 extends CustomType {
}
class Config15 extends CustomType {
  constructor(checked, disabled2, icons2, name2, value) {
    super();
    this.checked = checked;
    this.disabled = disabled2;
    this.icons = icons2;
    this.name = name2;
    this.value = value;
  }
}
var default_icons = /* @__PURE__ */ new None2;
var default_name5 = "";
var default_value4 = "on";
function default_config14() {
  return new Config15(new IsNotChecked, new IsNotDisabled6, new None2, "", "on");
}
function from_config13(config2) {
  return new Switch2(config2.checked, config2.disabled, config2.icons, config2.name, config2.value);
}
function new$27() {
  return from_config13(default_config14());
}
function checked(record, checked2) {
  return new Switch2(checked2, record.disabled, record.icons, record.name, record.value);
}
function disabled2(record, disabled3) {
  return new Switch2(record.checked, disabled3, record.icons, record.name, record.value);
}
function icons2(record, icons3) {
  return new Switch2(record.checked, record.disabled, icons3, record.name, record.value);
}
function render16(model, attributes, children) {
  return element2("m3e-switch", (() => {
    let _pipe = flatten(toList([
      toList([
        boolean("checked", model.checked instanceof IsChecked),
        boolean("disabled", model.disabled instanceof IsDisabled6),
        with_default("icons", to_string37(model.icons), to_string37(default_icons)),
        with_default("name", model.name, default_name5),
        with_default("value", model.value, default_value4)
      ]),
      attributes
    ]));
    return filter(_pipe, (a) => {
      return !isEqual(a, none());
    });
  })(), children);
}
function render_config3(c, attributes, children) {
  return render16(from_config13(c), attributes, children);
}

// build/dev/javascript/showcase/components/switch_.mjs
function basic2(_) {
  return div(toList([]), toList([
    (() => {
      let _pipe = new$27();
      let _pipe$1 = checked(_pipe, new IsChecked);
      return render16(_pipe$1, toList([]), toList([]));
    })()
  ]));
}
function labels(_) {
  return div(toList([switch_style()]), toList([
    label(toList([switch_style()]), toList([
      render_config3(default_config14(), toList([]), toList([])),
      text2("Switch 1")
    ])),
    render_config3(default_config14(), toList([id("switch2")]), toList([])),
    label(toList([for$("switch2")]), toList([text2("Switch 2")]))
  ]));
}
function icons3(_) {
  return div(toList([switch_style()]), toList([
    (() => {
      let _pipe = new$27();
      let _pipe$1 = icons2(_pipe, new None2);
      return render16(_pipe$1, toList([]), toList([]));
    })(),
    label(toList([]), toList([text2("None")])),
    (() => {
      let _pipe = new$27();
      let _pipe$1 = checked(_pipe, new IsChecked);
      let _pipe$2 = icons2(_pipe$1, new Selected3);
      return render16(_pipe$2, toList([]), toList([]));
    })(),
    label(toList([]), toList([text2("Selected")])),
    (() => {
      let _pipe = new$27();
      let _pipe$1 = icons2(_pipe, new Both);
      return render16(_pipe$1, toList([]), toList([]));
    })(),
    label(toList([]), toList([text2("Both")]))
  ]));
}
function disabled3(_) {
  return div(toList([switch_style()]), toList([
    label(toList([switch_style()]), toList([
      (() => {
        let _pipe = new$27();
        let _pipe$1 = disabled2(_pipe, new IsDisabled6);
        return render16(_pipe$1, toList([]), toList([]));
      })(),
      text2("Disabled Switch 1")
    ])),
    (() => {
      let _pipe = new$27();
      let _pipe$1 = checked(_pipe, new IsChecked);
      let _pipe$2 = disabled2(_pipe$1, new IsDisabled6);
      return render16(_pipe$2, toList([id("disabled-on")]), toList([]));
    })(),
    label(toList([for$("disabled-on")]), toList([text2("Disabled Switch 2")]))
  ]));
}
function switch_(model) {
  return page(toList([
    panel(model, "Basic usage", basic2),
    panel(model, "Labels", labels),
    panel(model, "Icons", icons3),
    panel(model, "Disabling", disabled3)
  ]));
}
function package$6() {
  return new Package(new Switch, "Switch", switch_, new SwitchPageSelected);
}

// build/dev/javascript/showcase/view.mjs
function github() {
  return img(toList([
    attribute2("src", "https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png"),
    attribute2("alt", "GitHub"),
    attribute2("height", "40"),
    attribute2("width", "40")
  ]));
}
function appbar() {
  let _pipe = new$6();
  let _pipe$1 = for$2(_pipe, new Some("main-content"));
  return render(_pipe$1, toList([app_bar_style()]), toList([
    (() => {
      let _pipe$2 = new$9();
      let _pipe$3 = selected(_pipe$2, new IsSelected);
      let _pipe$4 = toggle(_pipe$3, new IsToggle);
      return render5(_pipe$4, toList([slot2(new Leading)]), toList([
        (() => {
          let _pipe$5 = new$8();
          let _pipe$6 = name(_pipe$5, "menu");
          let _pipe$7 = filled(_pipe$6, new IsFilled);
          return render4(_pipe$7, toList([]), toList([]));
        })(),
        (() => {
          let _pipe$5 = new$8();
          let _pipe$6 = name(_pipe$5, "menu_open");
          let _pipe$7 = filled(_pipe$6, new IsFilled);
          return render4(_pipe$7, toList([slot4(new Selected)]), toList([]));
        })(),
        (() => {
          let _pipe$5 = new$7(new Some("nav-drawer"));
          return render3(_pipe$5, toList([]), toList([]));
        })()
      ]));
    })(),
    span(toList([
      slot2(new Title),
      app_bar_title_style()
    ]), toList([
      text2("Gleam/Lustre Material 3 Expression demonstration")
    ])),
    span(toList([
      slot2(new Subtitle),
      app_bar_title_style()
    ]), toList([text2("v0.0.1")])),
    span(toList([slot2(new Trailing)]), toList([
      (() => {
        let _pipe$2 = new$9();
        let _pipe$3 = href(_pipe$2, "https://github.com/bruceesmith/m3e");
        return render5(_pipe$3, toList([id("github-button")]), toList([github()]));
      })(),
      (() => {
        let _pipe$2 = new$13();
        let _pipe$3 = for$3(_pipe$2, new Some("github-button"));
        return render9(_pipe$3, toList([]), toList([text2("Github")]));
      })()
    ]))
  ]));
}
function packages() {
  return toList([
    package$(),
    package$2(),
    package$3(),
    package$4(),
    package$5(),
    package$6()
  ]);
}
function content2(model) {
  let _pipe = find(packages(), (p) => {
    return isEqual(p.state, model.state);
  });
  let _pipe$1 = map4(_pipe, (p) => {
    return p.view(model);
  });
  return unwrap(_pipe$1, home(model));
}
function nav_menu_items() {
  return map2(packages(), (package$7) => {
    let _pipe = new$11();
    return render7(_pipe, toList([on_click(package$7.msg)]), toList([
      span(toList([slot5(new Label)]), toList([text2(package$7.label)]))
    ]));
  });
}
function menu() {
  let _pipe = new$10();
  return render6(_pipe, toList([
    id("nav-drawer"),
    slot3(new Start)
  ]), nav_menu_items());
}
function body(content3) {
  return render_config((() => {
    let _record = default_config3();
    return new Config4(_record.end, _record.end_mode, _record.end_divider, new IsStart, new Auto2, _record.start_divider);
  })(), toList([]), toList([
    div(toList([slot3(new Start)]), toList([menu()])),
    div(toList([]), toList([content3]))
  ]));
}
function view(model) {
  return render8((() => {
    let _pipe = new$12();
    let _pipe$1 = contrast(_pipe, new High);
    return scheme(_pipe$1, new Auto);
  })(), toList([]), toList([appbar(), body(content2(model))]));
}

// build/dev/javascript/showcase/app.mjs
var FILEPATH = "src/app.gleam";
function main() {
  let app = application(init, update2, view);
  let $ = start4(app, "#app", undefined);
  if (!($ instanceof Ok)) {
    throw makeError("let_assert", FILEPATH, "app", 8, "main", "Pattern match failed, no pattern matched the value.", { value: $, start: 139, end: 188, pattern_start: 150, pattern_end: 155 });
  }
  return;
}

// .lustre/build/app.mjs
main();
