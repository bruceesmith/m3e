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
class NonEmpty extends List {
  constructor(head, tail) {
    super();
    this.head = head;
    this.tail = tail;
  }
}
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
    bitArrayPrintDeprecationWarning("buffer", "Use BitArray.byteAt() or BitArray.rawBuffer instead");
    if (this.bitOffset !== 0 || this.bitSize % 8 !== 0) {
      throw new globalThis.Error("BitArray.buffer does not support unaligned bit arrays");
    }
    return this.rawBuffer;
  }
  get length() {
    bitArrayPrintDeprecationWarning("length", "Use BitArray.bitSize or BitArray.byteSize instead");
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
var isBitArrayDeprecationMessagePrinted = {};
function bitArrayPrintDeprecationWarning(name, message) {
  if (isBitArrayDeprecationMessagePrinted[name]) {
    return;
  }
  console.warn(`Deprecated BitArray.${name} property used in JavaScript FFI code. ${message}.`);
  isBitArrayDeprecationMessagePrinted[name] = true;
}
class Result extends CustomType {
  static isResult(data) {
    return data instanceof Result;
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
class Error extends Result {
  constructor(detail) {
    super();
    this[0] = detail;
  }
  isOk() {
    return false;
  }
}
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
// build/dev/javascript/gleam_stdlib/gleam/option.mjs
class Some extends CustomType {
  constructor($0) {
    super();
    this[0] = $0;
  }
}
class None extends CustomType {
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
var SHIFT = 5;
var BUCKET_SIZE = Math.pow(2, SHIFT);
var MASK = BUCKET_SIZE - 1;
var MAX_INDEX_NODE = BUCKET_SIZE / 2;
var MIN_ARRAY_NODE = BUCKET_SIZE / 4;
var ENTRY = 0;
var ARRAY_NODE = 1;
var INDEX_NODE = 2;
var COLLISION_NODE = 3;
var EMPTY = {
  type: INDEX_NODE,
  bitmap: 0,
  array: []
};
function mask(hash, shift) {
  return hash >>> shift & MASK;
}
function bitpos(hash, shift) {
  return 1 << mask(hash, shift);
}
function bitcount(x) {
  x -= x >> 1 & 1431655765;
  x = (x & 858993459) + (x >> 2 & 858993459);
  x = x + (x >> 4) & 252645135;
  x += x >> 8;
  x += x >> 16;
  return x & 127;
}
function index(bitmap, bit) {
  return bitcount(bitmap & bit - 1);
}
function cloneAndSet(arr, at, val) {
  const len = arr.length;
  const out = new Array(len);
  for (let i = 0;i < len; ++i) {
    out[i] = arr[i];
  }
  out[at] = val;
  return out;
}
function spliceIn(arr, at, val) {
  const len = arr.length;
  const out = new Array(len + 1);
  let i = 0;
  let g = 0;
  while (i < at) {
    out[g++] = arr[i++];
  }
  out[g++] = val;
  while (i < len) {
    out[g++] = arr[i++];
  }
  return out;
}
function spliceOut(arr, at) {
  const len = arr.length;
  const out = new Array(len - 1);
  let i = 0;
  let g = 0;
  while (i < at) {
    out[g++] = arr[i++];
  }
  ++i;
  while (i < len) {
    out[g++] = arr[i++];
  }
  return out;
}
function createNode(shift, key1, val1, key2hash, key2, val2) {
  const key1hash = getHash(key1);
  if (key1hash === key2hash) {
    return {
      type: COLLISION_NODE,
      hash: key1hash,
      array: [
        { type: ENTRY, k: key1, v: val1 },
        { type: ENTRY, k: key2, v: val2 }
      ]
    };
  }
  const addedLeaf = { val: false };
  return assoc(assocIndex(EMPTY, shift, key1hash, key1, val1, addedLeaf), shift, key2hash, key2, val2, addedLeaf);
}
function assoc(root2, shift, hash, key, val, addedLeaf) {
  switch (root2.type) {
    case ARRAY_NODE:
      return assocArray(root2, shift, hash, key, val, addedLeaf);
    case INDEX_NODE:
      return assocIndex(root2, shift, hash, key, val, addedLeaf);
    case COLLISION_NODE:
      return assocCollision(root2, shift, hash, key, val, addedLeaf);
  }
}
function assocArray(root2, shift, hash, key, val, addedLeaf) {
  const idx = mask(hash, shift);
  const node = root2.array[idx];
  if (node === undefined) {
    addedLeaf.val = true;
    return {
      type: ARRAY_NODE,
      size: root2.size + 1,
      array: cloneAndSet(root2.array, idx, { type: ENTRY, k: key, v: val })
    };
  }
  if (node.type === ENTRY) {
    if (isEqual(key, node.k)) {
      if (val === node.v) {
        return root2;
      }
      return {
        type: ARRAY_NODE,
        size: root2.size,
        array: cloneAndSet(root2.array, idx, {
          type: ENTRY,
          k: key,
          v: val
        })
      };
    }
    addedLeaf.val = true;
    return {
      type: ARRAY_NODE,
      size: root2.size,
      array: cloneAndSet(root2.array, idx, createNode(shift + SHIFT, node.k, node.v, hash, key, val))
    };
  }
  const n = assoc(node, shift + SHIFT, hash, key, val, addedLeaf);
  if (n === node) {
    return root2;
  }
  return {
    type: ARRAY_NODE,
    size: root2.size,
    array: cloneAndSet(root2.array, idx, n)
  };
}
function assocIndex(root2, shift, hash, key, val, addedLeaf) {
  const bit = bitpos(hash, shift);
  const idx = index(root2.bitmap, bit);
  if ((root2.bitmap & bit) !== 0) {
    const node = root2.array[idx];
    if (node.type !== ENTRY) {
      const n = assoc(node, shift + SHIFT, hash, key, val, addedLeaf);
      if (n === node) {
        return root2;
      }
      return {
        type: INDEX_NODE,
        bitmap: root2.bitmap,
        array: cloneAndSet(root2.array, idx, n)
      };
    }
    const nodeKey = node.k;
    if (isEqual(key, nodeKey)) {
      if (val === node.v) {
        return root2;
      }
      return {
        type: INDEX_NODE,
        bitmap: root2.bitmap,
        array: cloneAndSet(root2.array, idx, {
          type: ENTRY,
          k: key,
          v: val
        })
      };
    }
    addedLeaf.val = true;
    return {
      type: INDEX_NODE,
      bitmap: root2.bitmap,
      array: cloneAndSet(root2.array, idx, createNode(shift + SHIFT, nodeKey, node.v, hash, key, val))
    };
  } else {
    const n = root2.array.length;
    if (n >= MAX_INDEX_NODE) {
      const nodes = new Array(32);
      const jdx = mask(hash, shift);
      nodes[jdx] = assocIndex(EMPTY, shift + SHIFT, hash, key, val, addedLeaf);
      let j = 0;
      let bitmap = root2.bitmap;
      for (let i = 0;i < 32; i++) {
        if ((bitmap & 1) !== 0) {
          const node = root2.array[j++];
          nodes[i] = node;
        }
        bitmap = bitmap >>> 1;
      }
      return {
        type: ARRAY_NODE,
        size: n + 1,
        array: nodes
      };
    } else {
      const newArray = spliceIn(root2.array, idx, {
        type: ENTRY,
        k: key,
        v: val
      });
      addedLeaf.val = true;
      return {
        type: INDEX_NODE,
        bitmap: root2.bitmap | bit,
        array: newArray
      };
    }
  }
}
function assocCollision(root2, shift, hash, key, val, addedLeaf) {
  if (hash === root2.hash) {
    const idx = collisionIndexOf(root2, key);
    if (idx !== -1) {
      const entry = root2.array[idx];
      if (entry.v === val) {
        return root2;
      }
      return {
        type: COLLISION_NODE,
        hash,
        array: cloneAndSet(root2.array, idx, { type: ENTRY, k: key, v: val })
      };
    }
    const size = root2.array.length;
    addedLeaf.val = true;
    return {
      type: COLLISION_NODE,
      hash,
      array: cloneAndSet(root2.array, size, { type: ENTRY, k: key, v: val })
    };
  }
  return assoc({
    type: INDEX_NODE,
    bitmap: bitpos(root2.hash, shift),
    array: [root2]
  }, shift, hash, key, val, addedLeaf);
}
function collisionIndexOf(root2, key) {
  const size = root2.array.length;
  for (let i = 0;i < size; i++) {
    if (isEqual(key, root2.array[i].k)) {
      return i;
    }
  }
  return -1;
}
function find(root2, shift, hash, key) {
  switch (root2.type) {
    case ARRAY_NODE:
      return findArray(root2, shift, hash, key);
    case INDEX_NODE:
      return findIndex(root2, shift, hash, key);
    case COLLISION_NODE:
      return findCollision(root2, key);
  }
}
function findArray(root2, shift, hash, key) {
  const idx = mask(hash, shift);
  const node = root2.array[idx];
  if (node === undefined) {
    return;
  }
  if (node.type !== ENTRY) {
    return find(node, shift + SHIFT, hash, key);
  }
  if (isEqual(key, node.k)) {
    return node;
  }
  return;
}
function findIndex(root2, shift, hash, key) {
  const bit = bitpos(hash, shift);
  if ((root2.bitmap & bit) === 0) {
    return;
  }
  const idx = index(root2.bitmap, bit);
  const node = root2.array[idx];
  if (node.type !== ENTRY) {
    return find(node, shift + SHIFT, hash, key);
  }
  if (isEqual(key, node.k)) {
    return node;
  }
  return;
}
function findCollision(root2, key) {
  const idx = collisionIndexOf(root2, key);
  if (idx < 0) {
    return;
  }
  return root2.array[idx];
}
function without(root2, shift, hash, key) {
  switch (root2.type) {
    case ARRAY_NODE:
      return withoutArray(root2, shift, hash, key);
    case INDEX_NODE:
      return withoutIndex(root2, shift, hash, key);
    case COLLISION_NODE:
      return withoutCollision(root2, key);
  }
}
function withoutArray(root2, shift, hash, key) {
  const idx = mask(hash, shift);
  const node = root2.array[idx];
  if (node === undefined) {
    return root2;
  }
  let n = undefined;
  if (node.type === ENTRY) {
    if (!isEqual(node.k, key)) {
      return root2;
    }
  } else {
    n = without(node, shift + SHIFT, hash, key);
    if (n === node) {
      return root2;
    }
  }
  if (n === undefined) {
    if (root2.size <= MIN_ARRAY_NODE) {
      const arr = root2.array;
      const out = new Array(root2.size - 1);
      let i = 0;
      let j = 0;
      let bitmap = 0;
      while (i < idx) {
        const nv = arr[i];
        if (nv !== undefined) {
          out[j] = nv;
          bitmap |= 1 << i;
          ++j;
        }
        ++i;
      }
      ++i;
      while (i < arr.length) {
        const nv = arr[i];
        if (nv !== undefined) {
          out[j] = nv;
          bitmap |= 1 << i;
          ++j;
        }
        ++i;
      }
      return {
        type: INDEX_NODE,
        bitmap,
        array: out
      };
    }
    return {
      type: ARRAY_NODE,
      size: root2.size - 1,
      array: cloneAndSet(root2.array, idx, n)
    };
  }
  return {
    type: ARRAY_NODE,
    size: root2.size,
    array: cloneAndSet(root2.array, idx, n)
  };
}
function withoutIndex(root2, shift, hash, key) {
  const bit = bitpos(hash, shift);
  if ((root2.bitmap & bit) === 0) {
    return root2;
  }
  const idx = index(root2.bitmap, bit);
  const node = root2.array[idx];
  if (node.type !== ENTRY) {
    const n = without(node, shift + SHIFT, hash, key);
    if (n === node) {
      return root2;
    }
    if (n !== undefined) {
      return {
        type: INDEX_NODE,
        bitmap: root2.bitmap,
        array: cloneAndSet(root2.array, idx, n)
      };
    }
    if (root2.bitmap === bit) {
      return;
    }
    return {
      type: INDEX_NODE,
      bitmap: root2.bitmap ^ bit,
      array: spliceOut(root2.array, idx)
    };
  }
  if (isEqual(key, node.k)) {
    if (root2.bitmap === bit) {
      return;
    }
    return {
      type: INDEX_NODE,
      bitmap: root2.bitmap ^ bit,
      array: spliceOut(root2.array, idx)
    };
  }
  return root2;
}
function withoutCollision(root2, key) {
  const idx = collisionIndexOf(root2, key);
  if (idx < 0) {
    return root2;
  }
  if (root2.array.length === 1) {
    return;
  }
  return {
    type: COLLISION_NODE,
    hash: root2.hash,
    array: spliceOut(root2.array, idx)
  };
}
function forEach(root2, fn) {
  if (root2 === undefined) {
    return;
  }
  const items = root2.array;
  const size = items.length;
  for (let i = 0;i < size; i++) {
    const item = items[i];
    if (item === undefined) {
      continue;
    }
    if (item.type === ENTRY) {
      fn(item.v, item.k);
      continue;
    }
    forEach(item, fn);
  }
}

class Dict {
  static fromObject(o) {
    const keys = Object.keys(o);
    let m = Dict.new();
    for (let i = 0;i < keys.length; i++) {
      const k = keys[i];
      m = m.set(k, o[k]);
    }
    return m;
  }
  static fromMap(o) {
    let m = Dict.new();
    o.forEach((v, k) => {
      m = m.set(k, v);
    });
    return m;
  }
  static new() {
    return new Dict(undefined, 0);
  }
  constructor(root2, size) {
    this.root = root2;
    this.size = size;
  }
  get(key, notFound) {
    if (this.root === undefined) {
      return notFound;
    }
    const found = find(this.root, 0, getHash(key), key);
    if (found === undefined) {
      return notFound;
    }
    return found.v;
  }
  set(key, val) {
    const addedLeaf = { val: false };
    const root2 = this.root === undefined ? EMPTY : this.root;
    const newRoot = assoc(root2, 0, getHash(key), key, val, addedLeaf);
    if (newRoot === this.root) {
      return this;
    }
    return new Dict(newRoot, addedLeaf.val ? this.size + 1 : this.size);
  }
  delete(key) {
    if (this.root === undefined) {
      return this;
    }
    const newRoot = without(this.root, 0, getHash(key), key);
    if (newRoot === this.root) {
      return this;
    }
    if (newRoot === undefined) {
      return Dict.new();
    }
    return new Dict(newRoot, this.size - 1);
  }
  has(key) {
    if (this.root === undefined) {
      return false;
    }
    return find(this.root, 0, getHash(key), key) !== undefined;
  }
  entries() {
    if (this.root === undefined) {
      return [];
    }
    const result = [];
    this.forEach((v, k) => result.push([k, v]));
    return result;
  }
  forEach(fn) {
    forEach(this.root, fn);
  }
  hashCode() {
    let h = 0;
    this.forEach((v, k) => {
      h = h + hashMerge(getHash(v), getHash(k)) | 0;
    });
    return h;
  }
  equals(o) {
    if (!(o instanceof Dict) || this.size !== o.size) {
      return false;
    }
    try {
      this.forEach((v, k) => {
        if (!isEqual(o.get(k, !v), v)) {
          throw unequalDictSymbol;
        }
      });
      return true;
    } catch (e) {
      if (e === unequalDictSymbol) {
        return false;
      }
      throw e;
    }
  }
}
var unequalDictSymbol = /* @__PURE__ */ Symbol();

// build/dev/javascript/gleam_stdlib/gleam/order.mjs
class Lt extends CustomType {
}
class Eq extends CustomType {
}
class Gt extends CustomType {
}

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
function append_loop(loop$first, loop$second) {
  while (true) {
    let first = loop$first;
    let second = loop$second;
    if (first instanceof Empty) {
      return second;
    } else {
      let first$1 = first.head;
      let rest$1 = first.tail;
      loop$first = rest$1;
      loop$second = prepend(first$1, second);
    }
  }
}
function append(first, second) {
  return append_loop(reverse(first), second);
}
function prepend2(list, item) {
  return prepend(item, list);
}
function fold(loop$list, loop$initial, loop$fun) {
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
function sequences(loop$list, loop$compare, loop$growing, loop$direction, loop$prev, loop$acc) {
  while (true) {
    let list = loop$list;
    let compare3 = loop$compare;
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
      let $ = compare3(prev, new$1);
      if (direction instanceof Ascending) {
        if ($ instanceof Lt) {
          loop$list = rest$1;
          loop$compare = compare3;
          loop$growing = growing$1;
          loop$direction = direction;
          loop$prev = new$1;
          loop$acc = acc;
        } else if ($ instanceof Eq) {
          loop$list = rest$1;
          loop$compare = compare3;
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
            let $1 = compare3(new$1, next);
            if ($1 instanceof Lt) {
              _block$1 = new Ascending;
            } else if ($1 instanceof Eq) {
              _block$1 = new Ascending;
            } else {
              _block$1 = new Descending;
            }
            let direction$1 = _block$1;
            loop$list = rest$2;
            loop$compare = compare3;
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
          let $1 = compare3(new$1, next);
          if ($1 instanceof Lt) {
            _block$1 = new Ascending;
          } else if ($1 instanceof Eq) {
            _block$1 = new Ascending;
          } else {
            _block$1 = new Descending;
          }
          let direction$1 = _block$1;
          loop$list = rest$2;
          loop$compare = compare3;
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
          let $1 = compare3(new$1, next);
          if ($1 instanceof Lt) {
            _block$1 = new Ascending;
          } else if ($1 instanceof Eq) {
            _block$1 = new Ascending;
          } else {
            _block$1 = new Descending;
          }
          let direction$1 = _block$1;
          loop$list = rest$2;
          loop$compare = compare3;
          loop$growing = toList([new$1]);
          loop$direction = direction$1;
          loop$prev = next;
          loop$acc = acc$1;
        }
      } else {
        loop$list = rest$1;
        loop$compare = compare3;
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
    let compare3 = loop$compare;
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
      let $ = compare3(first1, first2);
      if ($ instanceof Lt) {
        loop$list1 = rest1;
        loop$list2 = list2;
        loop$compare = compare3;
        loop$acc = prepend(first1, acc);
      } else if ($ instanceof Eq) {
        loop$list1 = list1;
        loop$list2 = rest2;
        loop$compare = compare3;
        loop$acc = prepend(first2, acc);
      } else {
        loop$list1 = list1;
        loop$list2 = rest2;
        loop$compare = compare3;
        loop$acc = prepend(first2, acc);
      }
    }
  }
}
function merge_ascending_pairs(loop$sequences, loop$compare, loop$acc) {
  while (true) {
    let sequences2 = loop$sequences;
    let compare3 = loop$compare;
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
        let descending = merge_ascendings(ascending1, ascending2, compare3, toList([]));
        loop$sequences = rest$1;
        loop$compare = compare3;
        loop$acc = prepend(descending, acc);
      }
    }
  }
}
function merge_descendings(loop$list1, loop$list2, loop$compare, loop$acc) {
  while (true) {
    let list1 = loop$list1;
    let list2 = loop$list2;
    let compare3 = loop$compare;
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
      let $ = compare3(first1, first2);
      if ($ instanceof Lt) {
        loop$list1 = list1;
        loop$list2 = rest2;
        loop$compare = compare3;
        loop$acc = prepend(first2, acc);
      } else if ($ instanceof Eq) {
        loop$list1 = rest1;
        loop$list2 = list2;
        loop$compare = compare3;
        loop$acc = prepend(first1, acc);
      } else {
        loop$list1 = rest1;
        loop$list2 = list2;
        loop$compare = compare3;
        loop$acc = prepend(first1, acc);
      }
    }
  }
}
function merge_descending_pairs(loop$sequences, loop$compare, loop$acc) {
  while (true) {
    let sequences2 = loop$sequences;
    let compare3 = loop$compare;
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
        let ascending = merge_descendings(descending1, descending2, compare3, toList([]));
        loop$sequences = rest$1;
        loop$compare = compare3;
        loop$acc = prepend(ascending, acc);
      }
    }
  }
}
function merge_all(loop$sequences, loop$direction, loop$compare) {
  while (true) {
    let sequences2 = loop$sequences;
    let direction = loop$direction;
    let compare3 = loop$compare;
    if (sequences2 instanceof Empty) {
      return sequences2;
    } else if (direction instanceof Ascending) {
      let $ = sequences2.tail;
      if ($ instanceof Empty) {
        let sequence = sequences2.head;
        return sequence;
      } else {
        let sequences$1 = merge_ascending_pairs(sequences2, compare3, toList([]));
        loop$sequences = sequences$1;
        loop$direction = new Descending;
        loop$compare = compare3;
      }
    } else {
      let $ = sequences2.tail;
      if ($ instanceof Empty) {
        let sequence = sequences2.head;
        return reverse(sequence);
      } else {
        let sequences$1 = merge_descending_pairs(sequences2, compare3, toList([]));
        loop$sequences = sequences$1;
        loop$direction = new Ascending;
        loop$compare = compare3;
      }
    }
  }
}
function sort(list, compare3) {
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
      let $1 = compare3(x, y);
      if ($1 instanceof Lt) {
        _block = new Ascending;
      } else if ($1 instanceof Eq) {
        _block = new Ascending;
      } else {
        _block = new Descending;
      }
      let direction = _block;
      let sequences$1 = sequences(rest$1, compare3, toList([x]), direction, y, toList([]));
      return merge_all(sequences$1, new Ascending, compare3);
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
function is_empty2(str) {
  return str === "";
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

// build/dev/javascript/gleam_stdlib/gleam/dynamic/decode.mjs
class Decoder extends CustomType {
  constructor(function$) {
    super();
    this.function = function$;
  }
}
function run(data, decoder) {
  let $ = decoder.function(data);
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
function success(data) {
  return new Decoder((_) => {
    return [data, toList([])];
  });
}
function map2(decoder, transformer) {
  return new Decoder((d) => {
    let $ = decoder.function(d);
    let data;
    let errors;
    data = $[0];
    errors = $[1];
    return [transformer(data), errors];
  });
}

// build/dev/javascript/gleam_stdlib/gleam_stdlib.mjs
var Nil = undefined;
var NOT_FOUND = {};
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
var segmenter = undefined;
function graphemes_iterator(string2) {
  if (globalThis.Intl && Intl.Segmenter) {
    segmenter ||= new Intl.Segmenter;
    return segmenter.segment(string2)[Symbol.iterator]();
  }
}
function starts_with(haystack, needle) {
  return haystack.startsWith(needle);
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
function new_map() {
  return Dict.new();
}
function map_to_list(map3) {
  return List.fromArray(map3.entries());
}
function map_get(map3, key) {
  const value = map3.get(key, NOT_FOUND);
  if (value === NOT_FOUND) {
    return new Error(Nil);
  }
  return new Ok(value);
}
function map_insert(key, value, map3) {
  return map3.set(key, value);
}
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
    } else if (v instanceof List) {
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
  #dict(map3) {
    let body = "dict.from_list([";
    let first = true;
    map3.forEach((value, key) => {
      if (!first)
        body = body + ", ";
      body = body + "#(" + this.inspect(key) + ", " + this.inspect(value) + ")";
      first = false;
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
    if (list2 instanceof Empty) {
      return "[]";
    }
    let char_out = 'charlist.from_string("';
    let list_out = "[";
    let current = list2;
    while (current instanceof NonEmpty) {
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
  #bit_array(bits) {
    if (bits.bitSize === 0) {
      return "<<>>";
    }
    let acc = "<<";
    for (let i = 0;i < bits.byteSize - 1; i++) {
      acc += bits.byteAt(i).toString();
      acc += ", ";
    }
    if (bits.byteSize * 8 === bits.bitSize) {
      acc += bits.byteAt(bits.byteSize - 1).toString();
    } else {
      const trailingBitsCount = bits.bitSize % 8;
      acc += bits.byteAt(bits.byteSize - 1) >> 8 - trailingBitsCount;
      acc += `:size(${trailingBitsCount})`;
    }
    acc += ">>";
    return acc;
  }
}

// build/dev/javascript/gleam_stdlib/gleam/dict.mjs
function insert(dict2, key, value) {
  return map_insert(key, value, dict2);
}
function reverse_and_concat(loop$remaining, loop$accumulator) {
  while (true) {
    let remaining = loop$remaining;
    let accumulator = loop$accumulator;
    if (remaining instanceof Empty) {
      return accumulator;
    } else {
      let first = remaining.head;
      let rest = remaining.tail;
      loop$remaining = rest;
      loop$accumulator = prepend(first, accumulator);
    }
  }
}
function do_keys_loop(loop$list, loop$acc) {
  while (true) {
    let list2 = loop$list;
    let acc = loop$acc;
    if (list2 instanceof Empty) {
      return reverse_and_concat(acc, toList([]));
    } else {
      let rest = list2.tail;
      let key = list2.head[0];
      loop$list = rest;
      loop$acc = prepend(key, acc);
    }
  }
}
function keys(dict2) {
  return do_keys_loop(map_to_list(dict2), toList([]));
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
// build/dev/javascript/gleam_json/gleam_json_ffi.mjs
function identity3(x) {
  return x;
}

// build/dev/javascript/gleam_json/gleam/json.mjs
function bool(input) {
  return identity3(input);
}

// build/dev/javascript/lustre/lustre/internals/constants.ffi.mjs
var document = () => globalThis?.document;
var NAMESPACE_HTML = "http://www.w3.org/1999/xhtml";
var ELEMENT_NODE = 1;
var TEXT_NODE = 3;
var SUPPORTS_MOVE_BEFORE = !!globalThis.HTMLElement?.prototype?.moveBefore;

// build/dev/javascript/lustre/lustre/internals/constants.mjs
var empty_list = /* @__PURE__ */ toList([]);
var option_none = /* @__PURE__ */ new None;

// build/dev/javascript/lustre/lustre/vdom/vattr.ffi.mjs
var GT = /* @__PURE__ */ new Gt;
var LT = /* @__PURE__ */ new Lt;
var EQ = /* @__PURE__ */ new Eq;
function compare3(a, b) {
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
        return compare3(b, a);
      });
      return merge(_pipe$1, empty_list);
    }
  }
}
function attribute(name, value) {
  return new Attribute(attribute_kind, name, value);
}
function property(name, value) {
  return new Property(property_kind, name, value);
}
function event(name, handler, include, prevent_default, stop_propagation, debounce, throttle) {
  return new Event2(event_kind, name, handler, include, prevent_default, stop_propagation, debounce, throttle);
}

// build/dev/javascript/lustre/lustre/attribute.mjs
function attribute2(name, value) {
  return attribute(name, value);
}
function property2(name, value) {
  return property(name, value);
}
function boolean_attribute(name, value) {
  if (value) {
    return attribute2(name, "");
  } else {
    return property2(name, bool(false));
  }
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
function href(url) {
  return attribute2("href", url);
}
function target(value) {
  return attribute2("target", value);
}
function disabled(is_disabled) {
  return boolean_attribute("disabled", is_disabled);
}
function for$(id2) {
  return attribute2("for", id2);
}
function name(element_name) {
  return attribute2("name", element_name);
}
function selected(is_selected) {
  return boolean_attribute("selected", is_selected);
}
function value(control_value) {
  return attribute2("value", control_value);
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
  constructor(dispatch, emit, select, root2, provide) {
    super();
    this.dispatch = dispatch;
    this.emit = emit;
    this.select = select;
    this.root = root2;
    this.provide = provide;
  }
}
var empty = /* @__PURE__ */ new Effect(/* @__PURE__ */ toList([]), /* @__PURE__ */ toList([]), /* @__PURE__ */ toList([]));
function perform(effect, dispatch, emit, select, root2, provide) {
  let actions = new Actions(dispatch, emit, select, root2, provide);
  return each(effect.synchronous, (run2) => {
    return run2(actions);
  });
}
function none2() {
  return empty;
}
function batch(effects) {
  return fold(effects, empty, (acc, eff) => {
    return new Effect(fold(eff.synchronous, acc.synchronous, prepend2), fold(eff.before_paint, acc.before_paint, prepend2), fold(eff.after_paint, acc.after_paint, prepend2));
  });
}

// build/dev/javascript/lustre/lustre/internals/mutable_map.ffi.mjs
function empty2() {
  return null;
}
function get(map3, key) {
  const value2 = map3?.get(key);
  if (value2 != null) {
    return new Ok(value2);
  } else {
    return new Error(undefined);
  }
}
function has_key2(map3, key) {
  return map3 && map3.has(key);
}
function insert2(map3, key, value2) {
  map3 ??= new Map;
  map3.set(key, value2);
  return map3;
}
function remove(map3, key) {
  map3?.delete(key);
  return map3;
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
var root2 = /* @__PURE__ */ new Root;
var separator_element = "\t";
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
function do_to_string(loop$path, loop$acc) {
  while (true) {
    let path = loop$path;
    let acc = loop$acc;
    if (path instanceof Root) {
      if (acc instanceof Empty) {
        return "";
      } else {
        let segments = acc.tail;
        return concat2(segments);
      }
    } else if (path instanceof Key) {
      let key = path.key;
      let parent = path.parent;
      loop$path = parent;
      loop$acc = prepend(separator_element, prepend(key, acc));
    } else {
      let index3 = path.index;
      let parent = path.parent;
      loop$path = parent;
      loop$acc = prepend(separator_element, prepend(to_string(index3), acc));
    }
  }
}
function to_string2(path) {
  return do_to_string(path, toList([]));
}
function matches(path, candidates) {
  if (candidates instanceof Empty) {
    return false;
  } else {
    return do_matches(to_string2(path), candidates);
  }
}
function event2(path, event3) {
  return do_to_string(path, toList([separator_event, event3]));
}

// build/dev/javascript/lustre/lustre/vdom/vnode.mjs
class Fragment extends CustomType {
  constructor(kind, key, mapper, children, keyed_children) {
    super();
    this.kind = kind;
    this.key = key;
    this.mapper = mapper;
    this.children = children;
    this.keyed_children = keyed_children;
  }
}
class Element extends CustomType {
  constructor(kind, key, mapper, namespace, tag, attributes, children, keyed_children, self_closing, void$) {
    super();
    this.kind = kind;
    this.key = key;
    this.mapper = mapper;
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
  constructor(kind, key, mapper, content) {
    super();
    this.kind = kind;
    this.key = key;
    this.mapper = mapper;
    this.content = content;
  }
}
class UnsafeInnerHtml extends CustomType {
  constructor(kind, key, mapper, namespace, tag, attributes, inner_html) {
    super();
    this.kind = kind;
    this.key = key;
    this.mapper = mapper;
    this.namespace = namespace;
    this.tag = tag;
    this.attributes = attributes;
    this.inner_html = inner_html;
  }
}
var fragment_kind = 0;
var element_kind = 1;
var text_kind = 2;
var unsafe_inner_html_kind = 3;
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
    return new Fragment(node.kind, key, node.mapper, node.children, node.keyed_children);
  } else if (node instanceof Element) {
    return new Element(node.kind, key, node.mapper, node.namespace, node.tag, node.attributes, node.children, node.keyed_children, node.self_closing, node.void);
  } else if (node instanceof Text) {
    return new Text(node.kind, key, node.mapper, node.content);
  } else {
    return new UnsafeInnerHtml(node.kind, key, node.mapper, node.namespace, node.tag, node.attributes, node.inner_html);
  }
}
function fragment(key, mapper, children, keyed_children) {
  return new Fragment(fragment_kind, key, mapper, children, keyed_children);
}
function element(key, mapper, namespace, tag, attributes, children, keyed_children, self_closing, void$) {
  return new Element(element_kind, key, mapper, namespace, tag, prepare(attributes), children, keyed_children, self_closing, void$);
}
function text(key, mapper, content) {
  return new Text(text_kind, key, mapper, content);
}

// build/dev/javascript/lustre/lustre/internals/equals.ffi.mjs
var isReferenceEqual = (a, b) => a === b;
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

// build/dev/javascript/lustre/lustre/vdom/events.mjs
class Events extends CustomType {
  constructor(handlers, dispatched_paths, next_dispatched_paths) {
    super();
    this.handlers = handlers;
    this.dispatched_paths = dispatched_paths;
    this.next_dispatched_paths = next_dispatched_paths;
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
function new$3() {
  return new Events(empty2(), empty_list, empty_list);
}
function tick(events) {
  return new Events(events.handlers, events.next_dispatched_paths, empty_list);
}
function do_remove_event(handlers, path, name2) {
  return remove(handlers, event2(path, name2));
}
function remove_event(events, path, name2) {
  let handlers = do_remove_event(events.handlers, path, name2);
  return new Events(handlers, events.dispatched_paths, events.next_dispatched_paths);
}
function remove_attributes(handlers, path, attributes) {
  return fold(attributes, handlers, (events, attribute3) => {
    if (attribute3 instanceof Event2) {
      let name2 = attribute3.name;
      return do_remove_event(events, path, name2);
    } else {
      return events;
    }
  });
}
function decode2(events, path, name2, event3) {
  let $ = get(events.handlers, path + separator_event + name2);
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
function dispatch(events, event3) {
  let next_dispatched_paths = prepend(event3.path, events.next_dispatched_paths);
  let events$1 = new Events(events.handlers, events.dispatched_paths, next_dispatched_paths);
  if (event3 instanceof DecodedEvent) {
    let handler = event3.handler;
    return [events$1, new Ok(handler)];
  } else {
    return [events$1, new Error(undefined)];
  }
}
function handle(events, path, name2, event3) {
  let _pipe = decode2(events, path, name2, event3);
  return ((_capture) => {
    return dispatch(events, _capture);
  })(_pipe);
}
function has_dispatched_events(events, path) {
  return matches(path, events.dispatched_paths);
}
function do_add_event(handlers, mapper, path, name2, handler) {
  return insert2(handlers, event2(path, name2), map2(handler, (handler2) => {
    return new Handler(handler2.prevent_default, handler2.stop_propagation, identity2(mapper)(handler2.message));
  }));
}
function add_event(events, mapper, path, name2, handler) {
  let handlers = do_add_event(events.handlers, mapper, path, name2, handler);
  return new Events(handlers, events.dispatched_paths, events.next_dispatched_paths);
}
function add_attributes(handlers, mapper, path, attributes) {
  return fold(attributes, handlers, (events, attribute3) => {
    if (attribute3 instanceof Event2) {
      let name2 = attribute3.name;
      let handler = attribute3.handler;
      return do_add_event(events, mapper, path, name2, handler);
    } else {
      return events;
    }
  });
}
function compose_mapper(mapper, child_mapper) {
  let $ = isReferenceEqual(mapper, identity2);
  let $1 = isReferenceEqual(child_mapper, identity2);
  if ($1) {
    return mapper;
  } else if ($) {
    return child_mapper;
  } else {
    return (msg) => {
      return mapper(child_mapper(msg));
    };
  }
}
function do_remove_children(loop$handlers, loop$path, loop$child_index, loop$children) {
  while (true) {
    let handlers = loop$handlers;
    let path = loop$path;
    let child_index = loop$child_index;
    let children = loop$children;
    if (children instanceof Empty) {
      return handlers;
    } else {
      let child = children.head;
      let rest = children.tail;
      let _pipe = handlers;
      let _pipe$1 = do_remove_child(_pipe, path, child_index, child);
      loop$handlers = _pipe$1;
      loop$path = path;
      loop$child_index = child_index + 1;
      loop$children = rest;
    }
  }
}
function do_remove_child(handlers, parent, child_index, child) {
  if (child instanceof Fragment) {
    let children = child.children;
    let path = add2(parent, child_index, child.key);
    return do_remove_children(handlers, path, 0, children);
  } else if (child instanceof Element) {
    let attributes = child.attributes;
    let children = child.children;
    let path = add2(parent, child_index, child.key);
    let _pipe = handlers;
    let _pipe$1 = remove_attributes(_pipe, path, attributes);
    return do_remove_children(_pipe$1, path, 0, children);
  } else if (child instanceof Text) {
    return handlers;
  } else {
    let attributes = child.attributes;
    let path = add2(parent, child_index, child.key);
    return remove_attributes(handlers, path, attributes);
  }
}
function remove_child(events, parent, child_index, child) {
  let handlers = do_remove_child(events.handlers, parent, child_index, child);
  return new Events(handlers, events.dispatched_paths, events.next_dispatched_paths);
}
function do_add_children(loop$handlers, loop$mapper, loop$path, loop$child_index, loop$children) {
  while (true) {
    let handlers = loop$handlers;
    let mapper = loop$mapper;
    let path = loop$path;
    let child_index = loop$child_index;
    let children = loop$children;
    if (children instanceof Empty) {
      return handlers;
    } else {
      let child = children.head;
      let rest = children.tail;
      let _pipe = handlers;
      let _pipe$1 = do_add_child(_pipe, mapper, path, child_index, child);
      loop$handlers = _pipe$1;
      loop$mapper = mapper;
      loop$path = path;
      loop$child_index = child_index + 1;
      loop$children = rest;
    }
  }
}
function do_add_child(handlers, mapper, parent, child_index, child) {
  if (child instanceof Fragment) {
    let children = child.children;
    let path = add2(parent, child_index, child.key);
    let composed_mapper = compose_mapper(mapper, child.mapper);
    return do_add_children(handlers, composed_mapper, path, 0, children);
  } else if (child instanceof Element) {
    let attributes = child.attributes;
    let children = child.children;
    let path = add2(parent, child_index, child.key);
    let composed_mapper = compose_mapper(mapper, child.mapper);
    let _pipe = handlers;
    let _pipe$1 = add_attributes(_pipe, composed_mapper, path, attributes);
    return do_add_children(_pipe$1, composed_mapper, path, 0, children);
  } else if (child instanceof Text) {
    return handlers;
  } else {
    let attributes = child.attributes;
    let path = add2(parent, child_index, child.key);
    let composed_mapper = compose_mapper(mapper, child.mapper);
    return add_attributes(handlers, composed_mapper, path, attributes);
  }
}
function add_child(events, mapper, parent, index3, child) {
  let handlers = do_add_child(events.handlers, mapper, parent, index3, child);
  return new Events(handlers, events.dispatched_paths, events.next_dispatched_paths);
}
function from_node(root3) {
  return add_child(new$3(), identity2, root2, 0, root3);
}
function add_children(events, mapper, path, child_index, children) {
  let handlers = do_add_children(events.handlers, mapper, path, child_index, children);
  return new Events(handlers, events.dispatched_paths, events.next_dispatched_paths);
}

// build/dev/javascript/lustre/lustre/element.mjs
function element2(tag, attributes, children) {
  return element("", identity2, "", tag, attributes, children, empty2(), false, is_void_html_element(tag, ""));
}
function text2(content) {
  return text("", identity2, content);
}
function none3() {
  return text("", identity2, "");
}

// build/dev/javascript/lustre/lustre/element/html.mjs
function text3(content) {
  return text2(content);
}
function div(attrs, children) {
  return element2("div", attrs, children);
}
function p(attrs, children) {
  return element2("p", attrs, children);
}
function br(attrs) {
  return element2("br", attrs, empty_list);
}
function span(attrs, children) {
  return element2("span", attrs, children);
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
function new$5(index3, removed, changes, children) {
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
  constructor(kind, open_shadow_root, will_adopt_styles, observed_attributes, observed_properties, requested_contexts, provided_contexts, vdom) {
    super();
    this.kind = kind;
    this.open_shadow_root = open_shadow_root;
    this.will_adopt_styles = will_adopt_styles;
    this.observed_attributes = observed_attributes;
    this.observed_properties = observed_properties;
    this.requested_contexts = requested_contexts;
    this.provided_contexts = provided_contexts;
    this.vdom = vdom;
  }
}
class Reconcile extends CustomType {
  constructor(kind, patch) {
    super();
    this.kind = kind;
    this.patch = patch;
  }
}
class Emit extends CustomType {
  constructor(kind, name2, data) {
    super();
    this.kind = kind;
    this.name = name2;
    this.data = data;
  }
}
class Provide extends CustomType {
  constructor(kind, key, value2) {
    super();
    this.kind = kind;
    this.key = key;
    this.value = value2;
  }
}
class Batch extends CustomType {
  constructor(kind, messages) {
    super();
    this.kind = kind;
    this.messages = messages;
  }
}
class AttributeChanged extends CustomType {
  constructor(kind, name2, value2) {
    super();
    this.kind = kind;
    this.name = name2;
    this.value = value2;
  }
}
class PropertyChanged extends CustomType {
  constructor(kind, name2, value2) {
    super();
    this.kind = kind;
    this.name = name2;
    this.value = value2;
  }
}
class EventFired extends CustomType {
  constructor(kind, path, name2, event3) {
    super();
    this.kind = kind;
    this.path = path;
    this.name = name2;
    this.event = event3;
  }
}
class ContextProvided extends CustomType {
  constructor(kind, key, value2) {
    super();
    this.kind = kind;
    this.key = key;
    this.value = value2;
  }
}
var mount_kind = 0;
var reconcile_kind = 1;
var emit_kind = 2;
var provide_kind = 3;
function mount(open_shadow_root, will_adopt_styles, observed_attributes, observed_properties, requested_contexts, provided_contexts, vdom) {
  return new Mount(mount_kind, open_shadow_root, will_adopt_styles, observed_attributes, observed_properties, requested_contexts, provided_contexts, vdom);
}
function reconcile(patch) {
  return new Reconcile(reconcile_kind, patch);
}
function emit(name2, data) {
  return new Emit(emit_kind, name2, data);
}
function provide(key, value2) {
  return new Provide(provide_kind, key, value2);
}

// build/dev/javascript/lustre/lustre/vdom/diff.mjs
class Diff extends CustomType {
  constructor(patch, events) {
    super();
    this.patch = patch;
    this.events = events;
  }
}
class AttributeChange extends CustomType {
  constructor(added, removed, events) {
    super();
    this.added = added;
    this.removed = removed;
    this.events = events;
  }
}
function is_controlled(events, namespace, tag, path) {
  if (tag === "input" && namespace === "") {
    return has_dispatched_events(events, path);
  } else if (tag === "select" && namespace === "") {
    return has_dispatched_events(events, path);
  } else if (tag === "textarea" && namespace === "") {
    return has_dispatched_events(events, path);
  } else {
    return false;
  }
}
function diff_attributes(loop$controlled, loop$path, loop$mapper, loop$events, loop$old, loop$new, loop$added, loop$removed) {
  while (true) {
    let controlled = loop$controlled;
    let path = loop$path;
    let mapper = loop$mapper;
    let events = loop$events;
    let old = loop$old;
    let new$6 = loop$new;
    let added = loop$added;
    let removed = loop$removed;
    if (old instanceof Empty) {
      if (new$6 instanceof Empty) {
        return new AttributeChange(added, removed, events);
      } else {
        let $ = new$6.head;
        if ($ instanceof Event2) {
          let next = $;
          let new$1 = new$6.tail;
          let name2 = $.name;
          let handler = $.handler;
          let added$1 = prepend(next, added);
          let events$1 = add_event(events, mapper, path, name2, handler);
          loop$controlled = controlled;
          loop$path = path;
          loop$mapper = mapper;
          loop$events = events$1;
          loop$old = old;
          loop$new = new$1;
          loop$added = added$1;
          loop$removed = removed;
        } else {
          let next = $;
          let new$1 = new$6.tail;
          let added$1 = prepend(next, added);
          loop$controlled = controlled;
          loop$path = path;
          loop$mapper = mapper;
          loop$events = events;
          loop$old = old;
          loop$new = new$1;
          loop$added = added$1;
          loop$removed = removed;
        }
      }
    } else if (new$6 instanceof Empty) {
      let $ = old.head;
      if ($ instanceof Event2) {
        let prev = $;
        let old$1 = old.tail;
        let name2 = $.name;
        let removed$1 = prepend(prev, removed);
        let events$1 = remove_event(events, path, name2);
        loop$controlled = controlled;
        loop$path = path;
        loop$mapper = mapper;
        loop$events = events$1;
        loop$old = old$1;
        loop$new = new$6;
        loop$added = added;
        loop$removed = removed$1;
      } else {
        let prev = $;
        let old$1 = old.tail;
        let removed$1 = prepend(prev, removed);
        loop$controlled = controlled;
        loop$path = path;
        loop$mapper = mapper;
        loop$events = events;
        loop$old = old$1;
        loop$new = new$6;
        loop$added = added;
        loop$removed = removed$1;
      }
    } else {
      let prev = old.head;
      let remaining_old = old.tail;
      let next = new$6.head;
      let remaining_new = new$6.tail;
      let $ = compare3(prev, next);
      if ($ instanceof Lt) {
        if (prev instanceof Event2) {
          let name2 = prev.name;
          let removed$1 = prepend(prev, removed);
          let events$1 = remove_event(events, path, name2);
          loop$controlled = controlled;
          loop$path = path;
          loop$mapper = mapper;
          loop$events = events$1;
          loop$old = remaining_old;
          loop$new = new$6;
          loop$added = added;
          loop$removed = removed$1;
        } else {
          let removed$1 = prepend(prev, removed);
          loop$controlled = controlled;
          loop$path = path;
          loop$mapper = mapper;
          loop$events = events;
          loop$old = remaining_old;
          loop$new = new$6;
          loop$added = added;
          loop$removed = removed$1;
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
            loop$mapper = mapper;
            loop$events = events;
            loop$old = remaining_old;
            loop$new = remaining_new;
            loop$added = added$1;
            loop$removed = removed;
          } else if (next instanceof Event2) {
            let name2 = next.name;
            let handler = next.handler;
            let added$1 = prepend(next, added);
            let removed$1 = prepend(prev, removed);
            let events$1 = add_event(events, mapper, path, name2, handler);
            loop$controlled = controlled;
            loop$path = path;
            loop$mapper = mapper;
            loop$events = events$1;
            loop$old = remaining_old;
            loop$new = remaining_new;
            loop$added = added$1;
            loop$removed = removed$1;
          } else {
            let added$1 = prepend(next, added);
            let removed$1 = prepend(prev, removed);
            loop$controlled = controlled;
            loop$path = path;
            loop$mapper = mapper;
            loop$events = events;
            loop$old = remaining_old;
            loop$new = remaining_new;
            loop$added = added$1;
            loop$removed = removed$1;
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
            loop$mapper = mapper;
            loop$events = events;
            loop$old = remaining_old;
            loop$new = remaining_new;
            loop$added = added$1;
            loop$removed = removed;
          } else if (next instanceof Event2) {
            let name2 = next.name;
            let handler = next.handler;
            let added$1 = prepend(next, added);
            let removed$1 = prepend(prev, removed);
            let events$1 = add_event(events, mapper, path, name2, handler);
            loop$controlled = controlled;
            loop$path = path;
            loop$mapper = mapper;
            loop$events = events$1;
            loop$old = remaining_old;
            loop$new = remaining_new;
            loop$added = added$1;
            loop$removed = removed$1;
          } else {
            let added$1 = prepend(next, added);
            let removed$1 = prepend(prev, removed);
            loop$controlled = controlled;
            loop$path = path;
            loop$mapper = mapper;
            loop$events = events;
            loop$old = remaining_old;
            loop$new = remaining_new;
            loop$added = added$1;
            loop$removed = removed$1;
          }
        } else if (next instanceof Event2) {
          let name2 = next.name;
          let handler = next.handler;
          let has_changes = prev.prevent_default.kind !== next.prevent_default.kind || prev.stop_propagation.kind !== next.stop_propagation.kind || prev.debounce !== next.debounce || prev.throttle !== next.throttle;
          let _block;
          if (has_changes) {
            _block = prepend(next, added);
          } else {
            _block = added;
          }
          let added$1 = _block;
          let events$1 = add_event(events, mapper, path, name2, handler);
          loop$controlled = controlled;
          loop$path = path;
          loop$mapper = mapper;
          loop$events = events$1;
          loop$old = remaining_old;
          loop$new = remaining_new;
          loop$added = added$1;
          loop$removed = removed;
        } else {
          let name2 = prev.name;
          let added$1 = prepend(next, added);
          let removed$1 = prepend(prev, removed);
          let events$1 = remove_event(events, path, name2);
          loop$controlled = controlled;
          loop$path = path;
          loop$mapper = mapper;
          loop$events = events$1;
          loop$old = remaining_old;
          loop$new = remaining_new;
          loop$added = added$1;
          loop$removed = removed$1;
        }
      } else if (next instanceof Event2) {
        let name2 = next.name;
        let handler = next.handler;
        let added$1 = prepend(next, added);
        let events$1 = add_event(events, mapper, path, name2, handler);
        loop$controlled = controlled;
        loop$path = path;
        loop$mapper = mapper;
        loop$events = events$1;
        loop$old = old;
        loop$new = remaining_new;
        loop$added = added$1;
        loop$removed = removed;
      } else {
        let added$1 = prepend(next, added);
        loop$controlled = controlled;
        loop$path = path;
        loop$mapper = mapper;
        loop$events = events;
        loop$old = old;
        loop$new = remaining_new;
        loop$added = added$1;
        loop$removed = removed;
      }
    }
  }
}
function do_diff(loop$old, loop$old_keyed, loop$new, loop$new_keyed, loop$moved, loop$moved_offset, loop$removed, loop$node_index, loop$patch_index, loop$path, loop$changes, loop$children, loop$mapper, loop$events) {
  while (true) {
    let old = loop$old;
    let old_keyed = loop$old_keyed;
    let new$6 = loop$new;
    let new_keyed = loop$new_keyed;
    let moved = loop$moved;
    let moved_offset = loop$moved_offset;
    let removed = loop$removed;
    let node_index = loop$node_index;
    let patch_index = loop$patch_index;
    let path = loop$path;
    let changes = loop$changes;
    let children = loop$children;
    let mapper = loop$mapper;
    let events = loop$events;
    if (old instanceof Empty) {
      if (new$6 instanceof Empty) {
        return new Diff(new Patch(patch_index, removed, changes, children), events);
      } else {
        let events$1 = add_children(events, mapper, path, node_index, new$6);
        let insert4 = insert3(new$6, node_index - moved_offset);
        let changes$1 = prepend(insert4, changes);
        return new Diff(new Patch(patch_index, removed, changes$1, children), events$1);
      }
    } else if (new$6 instanceof Empty) {
      let prev = old.head;
      let old$1 = old.tail;
      let _block;
      let $ = prev.key === "" || !has_key2(moved, prev.key);
      if ($) {
        _block = removed + 1;
      } else {
        _block = removed;
      }
      let removed$1 = _block;
      let events$1 = remove_child(events, path, node_index, prev);
      loop$old = old$1;
      loop$old_keyed = old_keyed;
      loop$new = new$6;
      loop$new_keyed = new_keyed;
      loop$moved = moved;
      loop$moved_offset = moved_offset;
      loop$removed = removed$1;
      loop$node_index = node_index;
      loop$patch_index = patch_index;
      loop$path = path;
      loop$changes = changes;
      loop$children = children;
      loop$mapper = mapper;
      loop$events = events$1;
    } else {
      let prev = old.head;
      let next = new$6.head;
      if (prev.key !== next.key) {
        let old_remaining = old.tail;
        let new_remaining = new$6.tail;
        let next_did_exist = get(old_keyed, next.key);
        let prev_does_exist = has_key2(new_keyed, prev.key);
        if (prev_does_exist) {
          if (next_did_exist instanceof Ok) {
            let match = next_did_exist[0];
            let $ = has_key2(moved, prev.key);
            if ($) {
              loop$old = old_remaining;
              loop$old_keyed = old_keyed;
              loop$new = new$6;
              loop$new_keyed = new_keyed;
              loop$moved = moved;
              loop$moved_offset = moved_offset - 1;
              loop$removed = removed;
              loop$node_index = node_index;
              loop$patch_index = patch_index;
              loop$path = path;
              loop$changes = changes;
              loop$children = children;
              loop$mapper = mapper;
              loop$events = events;
            } else {
              let before = node_index - moved_offset;
              let changes$1 = prepend(move(next.key, before), changes);
              let moved$1 = insert2(moved, next.key, undefined);
              let moved_offset$1 = moved_offset + 1;
              loop$old = prepend(match, old);
              loop$old_keyed = old_keyed;
              loop$new = new$6;
              loop$new_keyed = new_keyed;
              loop$moved = moved$1;
              loop$moved_offset = moved_offset$1;
              loop$removed = removed;
              loop$node_index = node_index;
              loop$patch_index = patch_index;
              loop$path = path;
              loop$changes = changes$1;
              loop$children = children;
              loop$mapper = mapper;
              loop$events = events;
            }
          } else {
            let before = node_index - moved_offset;
            let events$1 = add_child(events, mapper, path, node_index, next);
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
            loop$path = path;
            loop$changes = changes$1;
            loop$children = children;
            loop$mapper = mapper;
            loop$events = events$1;
          }
        } else if (next_did_exist instanceof Ok) {
          let index3 = node_index - moved_offset;
          let changes$1 = prepend(remove2(index3), changes);
          let events$1 = remove_child(events, path, node_index, prev);
          let moved_offset$1 = moved_offset - 1;
          loop$old = old_remaining;
          loop$old_keyed = old_keyed;
          loop$new = new$6;
          loop$new_keyed = new_keyed;
          loop$moved = moved;
          loop$moved_offset = moved_offset$1;
          loop$removed = removed;
          loop$node_index = node_index;
          loop$patch_index = patch_index;
          loop$path = path;
          loop$changes = changes$1;
          loop$children = children;
          loop$mapper = mapper;
          loop$events = events$1;
        } else {
          let change = replace2(node_index - moved_offset, next);
          let _block;
          let _pipe = events;
          let _pipe$1 = remove_child(_pipe, path, node_index, prev);
          _block = add_child(_pipe$1, mapper, path, node_index, next);
          let events$1 = _block;
          loop$old = old_remaining;
          loop$old_keyed = old_keyed;
          loop$new = new_remaining;
          loop$new_keyed = new_keyed;
          loop$moved = moved;
          loop$moved_offset = moved_offset;
          loop$removed = removed;
          loop$node_index = node_index + 1;
          loop$patch_index = patch_index;
          loop$path = path;
          loop$changes = prepend(change, changes);
          loop$children = children;
          loop$mapper = mapper;
          loop$events = events$1;
        }
      } else {
        let $ = old.head;
        if ($ instanceof Fragment) {
          let $1 = new$6.head;
          if ($1 instanceof Fragment) {
            let prev2 = $;
            let old$1 = old.tail;
            let next2 = $1;
            let new$1 = new$6.tail;
            let composed_mapper = compose_mapper(mapper, next2.mapper);
            let child_path = add2(path, node_index, next2.key);
            let child = do_diff(prev2.children, prev2.keyed_children, next2.children, next2.keyed_children, empty2(), 0, 0, 0, node_index, child_path, empty_list, empty_list, composed_mapper, events);
            let _block;
            let $2 = child.patch;
            let $3 = $2.changes;
            if ($3 instanceof Empty) {
              let $4 = $2.children;
              if ($4 instanceof Empty) {
                let $5 = $2.removed;
                if ($5 === 0) {
                  _block = children;
                } else {
                  _block = prepend(child.patch, children);
                }
              } else {
                _block = prepend(child.patch, children);
              }
            } else {
              _block = prepend(child.patch, children);
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
            loop$path = path;
            loop$changes = changes;
            loop$children = children$1;
            loop$mapper = mapper;
            loop$events = child.events;
          } else {
            let prev2 = $;
            let old_remaining = old.tail;
            let next2 = $1;
            let new_remaining = new$6.tail;
            let change = replace2(node_index - moved_offset, next2);
            let _block;
            let _pipe = events;
            let _pipe$1 = remove_child(_pipe, path, node_index, prev2);
            _block = add_child(_pipe$1, mapper, path, node_index, next2);
            let events$1 = _block;
            loop$old = old_remaining;
            loop$old_keyed = old_keyed;
            loop$new = new_remaining;
            loop$new_keyed = new_keyed;
            loop$moved = moved;
            loop$moved_offset = moved_offset;
            loop$removed = removed;
            loop$node_index = node_index + 1;
            loop$patch_index = patch_index;
            loop$path = path;
            loop$changes = prepend(change, changes);
            loop$children = children;
            loop$mapper = mapper;
            loop$events = events$1;
          }
        } else if ($ instanceof Element) {
          let $1 = new$6.head;
          if ($1 instanceof Element) {
            let prev2 = $;
            let next2 = $1;
            if (prev2.namespace === next2.namespace && prev2.tag === next2.tag) {
              let old$1 = old.tail;
              let new$1 = new$6.tail;
              let composed_mapper = compose_mapper(mapper, next2.mapper);
              let child_path = add2(path, node_index, next2.key);
              let controlled = is_controlled(events, next2.namespace, next2.tag, child_path);
              let $2 = diff_attributes(controlled, child_path, composed_mapper, events, prev2.attributes, next2.attributes, empty_list, empty_list);
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
              let child = do_diff(prev2.children, prev2.keyed_children, next2.children, next2.keyed_children, empty2(), 0, 0, 0, node_index, child_path, initial_child_changes, empty_list, composed_mapper, events$1);
              let _block$1;
              let $3 = child.patch;
              let $4 = $3.changes;
              if ($4 instanceof Empty) {
                let $5 = $3.children;
                if ($5 instanceof Empty) {
                  let $6 = $3.removed;
                  if ($6 === 0) {
                    _block$1 = children;
                  } else {
                    _block$1 = prepend(child.patch, children);
                  }
                } else {
                  _block$1 = prepend(child.patch, children);
                }
              } else {
                _block$1 = prepend(child.patch, children);
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
              loop$path = path;
              loop$changes = changes;
              loop$children = children$1;
              loop$mapper = mapper;
              loop$events = child.events;
            } else {
              let prev3 = $;
              let old_remaining = old.tail;
              let next3 = $1;
              let new_remaining = new$6.tail;
              let change = replace2(node_index - moved_offset, next3);
              let _block;
              let _pipe = events;
              let _pipe$1 = remove_child(_pipe, path, node_index, prev3);
              _block = add_child(_pipe$1, mapper, path, node_index, next3);
              let events$1 = _block;
              loop$old = old_remaining;
              loop$old_keyed = old_keyed;
              loop$new = new_remaining;
              loop$new_keyed = new_keyed;
              loop$moved = moved;
              loop$moved_offset = moved_offset;
              loop$removed = removed;
              loop$node_index = node_index + 1;
              loop$patch_index = patch_index;
              loop$path = path;
              loop$changes = prepend(change, changes);
              loop$children = children;
              loop$mapper = mapper;
              loop$events = events$1;
            }
          } else {
            let prev2 = $;
            let old_remaining = old.tail;
            let next2 = $1;
            let new_remaining = new$6.tail;
            let change = replace2(node_index - moved_offset, next2);
            let _block;
            let _pipe = events;
            let _pipe$1 = remove_child(_pipe, path, node_index, prev2);
            _block = add_child(_pipe$1, mapper, path, node_index, next2);
            let events$1 = _block;
            loop$old = old_remaining;
            loop$old_keyed = old_keyed;
            loop$new = new_remaining;
            loop$new_keyed = new_keyed;
            loop$moved = moved;
            loop$moved_offset = moved_offset;
            loop$removed = removed;
            loop$node_index = node_index + 1;
            loop$patch_index = patch_index;
            loop$path = path;
            loop$changes = prepend(change, changes);
            loop$children = children;
            loop$mapper = mapper;
            loop$events = events$1;
          }
        } else if ($ instanceof Text) {
          let $1 = new$6.head;
          if ($1 instanceof Text) {
            let prev2 = $;
            let next2 = $1;
            if (prev2.content === next2.content) {
              let old$1 = old.tail;
              let new$1 = new$6.tail;
              loop$old = old$1;
              loop$old_keyed = old_keyed;
              loop$new = new$1;
              loop$new_keyed = new_keyed;
              loop$moved = moved;
              loop$moved_offset = moved_offset;
              loop$removed = removed;
              loop$node_index = node_index + 1;
              loop$patch_index = patch_index;
              loop$path = path;
              loop$changes = changes;
              loop$children = children;
              loop$mapper = mapper;
              loop$events = events;
            } else {
              let old$1 = old.tail;
              let next3 = $1;
              let new$1 = new$6.tail;
              let child = new$5(node_index, 0, toList([replace_text(next3.content)]), empty_list);
              loop$old = old$1;
              loop$old_keyed = old_keyed;
              loop$new = new$1;
              loop$new_keyed = new_keyed;
              loop$moved = moved;
              loop$moved_offset = moved_offset;
              loop$removed = removed;
              loop$node_index = node_index + 1;
              loop$patch_index = patch_index;
              loop$path = path;
              loop$changes = changes;
              loop$children = prepend(child, children);
              loop$mapper = mapper;
              loop$events = events;
            }
          } else {
            let prev2 = $;
            let old_remaining = old.tail;
            let next2 = $1;
            let new_remaining = new$6.tail;
            let change = replace2(node_index - moved_offset, next2);
            let _block;
            let _pipe = events;
            let _pipe$1 = remove_child(_pipe, path, node_index, prev2);
            _block = add_child(_pipe$1, mapper, path, node_index, next2);
            let events$1 = _block;
            loop$old = old_remaining;
            loop$old_keyed = old_keyed;
            loop$new = new_remaining;
            loop$new_keyed = new_keyed;
            loop$moved = moved;
            loop$moved_offset = moved_offset;
            loop$removed = removed;
            loop$node_index = node_index + 1;
            loop$patch_index = patch_index;
            loop$path = path;
            loop$changes = prepend(change, changes);
            loop$children = children;
            loop$mapper = mapper;
            loop$events = events$1;
          }
        } else {
          let $1 = new$6.head;
          if ($1 instanceof UnsafeInnerHtml) {
            let prev2 = $;
            let old$1 = old.tail;
            let next2 = $1;
            let new$1 = new$6.tail;
            let composed_mapper = compose_mapper(mapper, next2.mapper);
            let child_path = add2(path, node_index, next2.key);
            let $2 = diff_attributes(false, child_path, composed_mapper, events, prev2.attributes, next2.attributes, empty_list, empty_list);
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
              _block$2 = prepend(new$5(node_index, 0, child_changes$1, toList([])), children);
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
            loop$path = path;
            loop$changes = changes;
            loop$children = children$1;
            loop$mapper = mapper;
            loop$events = events$1;
          } else {
            let prev2 = $;
            let old_remaining = old.tail;
            let next2 = $1;
            let new_remaining = new$6.tail;
            let change = replace2(node_index - moved_offset, next2);
            let _block;
            let _pipe = events;
            let _pipe$1 = remove_child(_pipe, path, node_index, prev2);
            _block = add_child(_pipe$1, mapper, path, node_index, next2);
            let events$1 = _block;
            loop$old = old_remaining;
            loop$old_keyed = old_keyed;
            loop$new = new_remaining;
            loop$new_keyed = new_keyed;
            loop$moved = moved;
            loop$moved_offset = moved_offset;
            loop$removed = removed;
            loop$node_index = node_index + 1;
            loop$patch_index = patch_index;
            loop$path = path;
            loop$changes = prepend(change, changes);
            loop$children = children;
            loop$mapper = mapper;
            loop$events = events$1;
          }
        }
      }
    }
  }
}
function diff(events, old, new$6) {
  return do_diff(toList([old]), empty2(), toList([new$6]), empty2(), empty2(), 0, 0, 0, 0, root2, empty_list, empty_list, identity2, tick(events));
}

// build/dev/javascript/lustre/lustre/vdom/reconciler.ffi.mjs
var setTimeout = globalThis.setTimeout;
var clearTimeout = globalThis.clearTimeout;
var createElementNS = (ns, name2) => document().createElementNS(ns, name2);
var createTextNode = (data) => document().createTextNode(data);
var createDocumentFragment = () => document().createDocumentFragment();
var insertBefore = (parent, node, reference) => parent.insertBefore(node, reference);
var moveBefore = SUPPORTS_MOVE_BEFORE ? (parent, node, reference) => parent.moveBefore(node, reference) : insertBefore;
var removeChild = (parent, child) => parent.removeChild(child);
var getAttribute = (node, name2) => node.getAttribute(name2);
var setAttribute = (node, name2, value2) => node.setAttribute(name2, value2);
var removeAttribute = (node, name2) => node.removeAttribute(name2);
var addEventListener = (node, name2, handler, options) => node.addEventListener(name2, handler, options);
var removeEventListener = (node, name2, handler) => node.removeEventListener(name2, handler);
var setInnerHtml = (node, innerHtml) => node.innerHTML = innerHtml;
var setData = (node, data) => node.data = data;
var meta = Symbol("lustre");

class MetadataNode {
  constructor(kind, parent, node, key) {
    this.kind = kind;
    this.key = key;
    this.parent = parent;
    this.children = [];
    this.node = node;
    this.handlers = new Map;
    this.throttles = new Map;
    this.debouncers = new Map;
  }
  get parentNode() {
    return this.kind === fragment_kind ? this.node.parentNode : this.node;
  }
}
var insertMetadataChild = (kind, parent, node, index3, key) => {
  const child = new MetadataNode(kind, parent, node, key);
  node[meta] = child;
  parent?.children.splice(index3, 0, child);
  return child;
};
var getPath = (node) => {
  let path = "";
  for (let current = node[meta];current.parent; current = current.parent) {
    if (current.key) {
      path = `${separator_element}${current.key}${path}`;
    } else {
      const index3 = current.parent.children.indexOf(current);
      path = `${separator_element}${index3}${path}`;
    }
  }
  return path.slice(1);
};

class Reconciler {
  #root = null;
  #decodeEvent;
  #dispatch;
  #exposeKeys = false;
  constructor(root3, decodeEvent, dispatch2, { exposeKeys = false } = {}) {
    this.#root = root3;
    this.#decodeEvent = decodeEvent;
    this.#dispatch = dispatch2;
    this.#exposeKeys = exposeKeys;
  }
  mount(vdom) {
    insertMetadataChild(element_kind, null, this.#root, 0, null);
    this.#insertChild(this.#root, null, this.#root[meta], 0, vdom);
  }
  push(patch) {
    this.#stack.push({ node: this.#root[meta], patch });
    this.#reconcile();
  }
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
        const child = childNodes[childPatch.index | 0];
        this.#stack.push({ node: child, patch: childPatch });
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
  #replace(parent, { index: index3, with: child }) {
    this.#removeChildren(parent, index3 | 0, 1);
    const beforeEl = this.#getReference(parent, index3);
    this.#insertChild(parent.parentNode, beforeEl, parent, index3 | 0, child);
  }
  #getReference(node, index3) {
    index3 = index3 | 0;
    const { children } = node;
    const childCount = children.length;
    if (index3 < childCount) {
      return children[index3].node;
    }
    let lastChild = children[childCount - 1];
    if (!lastChild && node.kind !== fragment_kind)
      return null;
    if (!lastChild)
      lastChild = node;
    while (lastChild.kind === fragment_kind && lastChild.children.length) {
      lastChild = lastChild.children[lastChild.children.length - 1];
    }
    return lastChild.node.nextSibling;
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
    const { kind, node, children: prevChildren } = prev;
    moveBefore(parentNode, node, beforeEl);
    if (kind === fragment_kind) {
      this.#moveChildren(parentNode, prevChildren, beforeEl);
    }
  }
  #moveChildren(domParent, children, beforeEl) {
    for (let i = 0;i < children.length; ++i) {
      const { kind, node, children: nestedChildren } = children[i];
      moveBefore(domParent, node, beforeEl);
      if (kind === fragment_kind) {
        this.#moveChildren(domParent, nestedChildren, beforeEl);
      }
    }
  }
  #remove(parent, { index: index3 }) {
    this.#removeChildren(parent, index3, 1);
  }
  #removeChildren(parent, index3, count) {
    const { children, parentNode } = parent;
    const deleted = children.splice(index3, count);
    for (let i = 0;i < deleted.length; ++i) {
      const { kind, node, children: nestedChildren } = deleted[i];
      removeChild(parentNode, node);
      this.#removeDebouncers(deleted[i]);
      if (kind === fragment_kind) {
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
    iterate(children, (child) => this.#removeDebouncers(child));
  }
  #update({ node, handlers, throttles, debouncers }, { added, removed }) {
    iterate(removed, ({ name: name2 }) => {
      if (handlers.delete(name2)) {
        removeEventListener(node, name2, handleEvent);
        this.#updateDebounceThrottle(throttles, name2, 0);
        this.#updateDebounceThrottle(debouncers, name2, 0);
      } else {
        removeAttribute(node, name2);
        SYNCED_ATTRIBUTES[name2]?.removed?.(node, name2);
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
    iterate(children, (child) => this.#insertChild(domParent, beforeEl, metaParent, index3++, child));
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
        const head = this.#createTextNode(metaParent, index3, vnode);
        insertBefore(domParent, head, beforeEl);
        this.#insertChildren(domParent, beforeEl, head[meta], 0, vnode.children);
        break;
      }
      case unsafe_inner_html_kind: {
        const node = this.#createElement(metaParent, index3, vnode);
        this.#replaceInnerHtml({ node }, vnode);
        insertBefore(domParent, node, beforeEl);
        break;
      }
    }
  }
  #createElement(parent, index3, { kind, key, tag, namespace, attributes }) {
    const node = createElementNS(namespace || NAMESPACE_HTML, tag);
    insertMetadataChild(kind, parent, node, index3, key);
    if (this.#exposeKeys && key) {
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
  #createAttribute(node, attribute3) {
    const { debouncers, handlers, throttles } = node[meta];
    const {
      kind,
      name: name2,
      value: value2,
      prevent_default: prevent,
      debounce: debounceDelay,
      throttle: throttleDelay
    } = attribute3;
    switch (kind) {
      case attribute_kind: {
        const valueOrDefault = value2 ?? "";
        if (name2 === "virtual:defaultValue") {
          node.defaultValue = valueOrDefault;
          return;
        } else if (name2 === "virtual:defaultChecked") {
          node.defaultChecked = true;
          return;
        } else if (name2 === "virtual:defaultSelected") {
          node.defaultSelected = true;
          return;
        }
        if (valueOrDefault !== getAttribute(node, name2)) {
          setAttribute(node, name2, valueOrDefault);
        }
        SYNCED_ATTRIBUTES[name2]?.added?.(node, valueOrDefault);
        break;
      }
      case property_kind:
        node[name2] = value2;
        break;
      case event_kind: {
        if (handlers.has(name2)) {
          removeEventListener(node, name2, handleEvent);
        }
        const passive = prevent.kind === never_kind;
        addEventListener(node, name2, handleEvent, { passive });
        this.#updateDebounceThrottle(throttles, name2, throttleDelay);
        this.#updateDebounceThrottle(debouncers, name2, debounceDelay);
        handlers.set(name2, (event3) => this.#handleEvent(attribute3, event3));
        break;
      }
    }
  }
  #updateDebounceThrottle(map3, name2, delay) {
    const debounceOrThrottle = map3.get(name2);
    if (delay > 0) {
      if (debounceOrThrottle) {
        debounceOrThrottle.delay = delay;
      } else {
        map3.set(name2, { delay });
      }
    } else if (debounceOrThrottle) {
      const { timeout } = debounceOrThrottle;
      if (timeout) {
        clearTimeout(timeout);
      }
      map3.delete(name2);
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
    const data = this.#decodeEvent(event3, path, type, include);
    const throttle = throttles.get(type);
    if (throttle) {
      const now = Date.now();
      const last = throttle.last || 0;
      if (now > last + throttle.delay) {
        throttle.last = now;
        throttle.lastEvent = event3;
        this.#dispatch(event3, data);
      }
    }
    const debounce = debouncers.get(type);
    if (debounce) {
      clearTimeout(debounce.timeout);
      debounce.timeout = setTimeout(() => {
        if (event3 === throttles.get(type)?.lastEvent)
          return;
        this.#dispatch(event3, data);
      }, debounce.delay);
    }
    if (!throttle && !debounce) {
      this.#dispatch(event3, data);
    }
  }
}
var iterate = (list4, callback) => {
  if (Array.isArray(list4)) {
    for (let i = 0;i < list4.length; i++) {
      callback(list4[i]);
    }
  } else if (list4) {
    for (list4;list4.head; list4 = list4.tail) {
      callback(list4.head);
    }
  }
};
var handleEvent = (event3) => {
  const { currentTarget, type } = event3;
  const handler = currentTarget[meta].handlers.get(type);
  handler(event3);
};
var syncedBooleanAttribute = (name2) => {
  return {
    added(node) {
      node[name2] = true;
    },
    removed(node) {
      node[name2] = false;
    }
  };
};
var syncedAttribute = (name2) => {
  return {
    added(node, value2) {
      node[name2] = value2;
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
  return element("", identity2, "", tag, attributes, children$1, keyed_children, false, is_void_html_element(tag, ""));
}
function namespaced2(namespace, tag, attributes, children) {
  let $ = extract_keyed_children(children);
  let keyed_children;
  let children$1;
  keyed_children = $[0];
  children$1 = $[1];
  return element("", identity2, namespace, tag, attributes, children$1, keyed_children, false, is_void_html_element(tag, namespace));
}
function fragment2(children) {
  let $ = extract_keyed_children(children);
  let keyed_children;
  let children$1;
  keyed_children = $[0];
  children$1 = $[1];
  return fragment("", identity2, children$1, keyed_children);
}

// build/dev/javascript/lustre/lustre/vdom/virtualise.ffi.mjs
var virtualise = (root3) => {
  const rootMeta = insertMetadataChild(element_kind, null, root3, 0, null);
  let virtualisableRootChildren = 0;
  for (let child = root3.firstChild;child; child = child.nextSibling) {
    if (canVirtualiseNode(child))
      virtualisableRootChildren += 1;
  }
  if (virtualisableRootChildren === 0) {
    const placeholder = document().createTextNode("");
    insertMetadataChild(text_kind, rootMeta, placeholder, 0, null);
    root3.replaceChildren(placeholder);
    return none3();
  }
  if (virtualisableRootChildren === 1) {
    const children2 = virtualiseChildNodes(rootMeta, root3);
    return children2.head[1];
  }
  const fragmentHead = document().createTextNode("");
  const fragmentMeta = insertMetadataChild(fragment_kind, rootMeta, fragmentHead, 0, null);
  const children = virtualiseChildNodes(fragmentMeta, root3);
  root3.insertBefore(fragmentHead, root3.firstChild);
  return fragment2(children);
};
var canVirtualiseNode = (node) => {
  switch (node.nodeType) {
    case ELEMENT_NODE:
      return true;
    case TEXT_NODE:
      return !!node.data;
    default:
      return false;
  }
};
var virtualiseNode = (meta2, node, key, index3) => {
  if (!canVirtualiseNode(node)) {
    return null;
  }
  switch (node.nodeType) {
    case ELEMENT_NODE: {
      const childMeta = insertMetadataChild(element_kind, meta2, node, index3, key);
      const tag = node.localName;
      const namespace = node.namespaceURI;
      const isHtmlElement = !namespace || namespace === NAMESPACE_HTML;
      if (isHtmlElement && INPUT_ELEMENTS.includes(tag)) {
        virtualiseInputEvents(tag, node);
      }
      const attributes = virtualiseAttributes(node);
      const children = virtualiseChildNodes(childMeta, node);
      const vnode = isHtmlElement ? element3(tag, attributes, children) : namespaced2(namespace, tag, attributes, children);
      return vnode;
    }
    case TEXT_NODE:
      insertMetadataChild(text_kind, meta2, node, index3, null);
      return text2(node.data);
    default:
      return null;
  }
};
var INPUT_ELEMENTS = ["input", "select", "textarea"];
var virtualiseInputEvents = (tag, node) => {
  const value2 = node.value;
  const checked = node.checked;
  if (tag === "input" && node.type === "checkbox" && !checked)
    return;
  if (tag === "input" && node.type === "radio" && !checked)
    return;
  if (node.type !== "checkbox" && node.type !== "radio" && !value2)
    return;
  queueMicrotask(() => {
    node.value = value2;
    node.checked = checked;
    node.dispatchEvent(new Event("input", { bubbles: true }));
    node.dispatchEvent(new Event("change", { bubbles: true }));
    if (document().activeElement !== node) {
      node.dispatchEvent(new Event("blur", { bubbles: true }));
    }
  });
};
var virtualiseChildNodes = (meta2, node) => {
  let children = null;
  let child = node.firstChild;
  let ptr = null;
  let index3 = 0;
  while (child) {
    const key = child.nodeType === ELEMENT_NODE ? child.getAttribute("data-lustre-key") : null;
    if (key != null) {
      child.removeAttribute("data-lustre-key");
    }
    const vnode = virtualiseNode(meta2, child, key, index3);
    const next = child.nextSibling;
    if (vnode) {
      const list_node = new NonEmpty([key ?? "", vnode], null);
      if (ptr) {
        ptr = ptr.tail = list_node;
      } else {
        ptr = children = list_node;
      }
      index3 += 1;
    } else {
      node.removeChild(child);
    }
    child = next;
  }
  if (!ptr)
    return empty_list;
  ptr.tail = empty_list;
  return children;
};
var virtualiseAttributes = (node) => {
  let index3 = node.attributes.length;
  let attributes = empty_list;
  while (index3-- > 0) {
    const attr = node.attributes[index3];
    if (attr.name === "xmlns") {
      continue;
    }
    attributes = new NonEmpty(virtualiseAttribute(attr), attributes);
  }
  return attributes;
};
var virtualiseAttribute = (attr) => {
  const name2 = attr.localName;
  const value2 = attr.value;
  return attribute2(name2, value2);
};

// build/dev/javascript/lustre/lustre/runtime/client/runtime.ffi.mjs
var is_browser = () => !!document();
class Runtime {
  constructor(root3, [model, effects], view, update2) {
    this.root = root3;
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
    const decodeEvent = (event3, path, name2) => decode2(this.#events, path, name2, event3);
    const dispatch2 = (event3, data) => {
      const [events, result] = dispatch(this.#events, data);
      this.#events = events;
      if (result.isOk()) {
        const handler = result[0];
        if (handler.stop_propagation)
          event3.stopPropagation();
        if (handler.prevent_default)
          event3.preventDefault();
        this.dispatch(handler.message, false);
      }
    };
    this.#reconciler = new Reconciler(this.root, decodeEvent, dispatch2);
    this.#vdom = virtualise(this.root);
    this.#events = new$3();
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
  emit(event3, data) {
    const target2 = this.root.host ?? this.root;
    target2.dispatchEvent(new CustomEvent(event3, {
      detail: data,
      bubbles: true,
      composed: true
    }));
  }
  provide(key, value2) {
    if (!this.#contexts.has(key)) {
      this.#contexts.set(key, { value: value2, subscribers: [] });
    } else {
      const context = this.#contexts.get(key);
      if (isEqual2(context.value, value2)) {
        return;
      }
      context.value = value2;
      for (let i = context.subscribers.length - 1;i >= 0; i--) {
        const [subscriber, unsubscribe] = context.subscribers[i];
        if (!subscriber) {
          context.subscribers.splice(i, 1);
          continue;
        }
        subscriber(value2, unsubscribe);
      }
    }
  }
  #model;
  #view;
  #update;
  #vdom;
  #events;
  #reconciler;
  #contexts = new Map;
  #shouldQueue = false;
  #queue = [];
  #beforePaint = empty_list;
  #afterPaint = empty_list;
  #renderTimer = null;
  #actions = {
    dispatch: (msg) => this.dispatch(msg),
    emit: (event3, data) => this.emit(event3, data),
    select: () => {},
    root: () => this.root,
    provide: (key, value2) => this.provide(key, value2)
  };
  #tick(effects, shouldFlush = false) {
    this.#handleEffects(effects);
    if (!this.#renderTimer) {
      if (shouldFlush) {
        this.#renderTimer = "sync";
        queueMicrotask(() => this.#render());
      } else {
        this.#renderTimer = requestAnimationFrame(() => this.#render());
      }
    }
  }
  #handleEffects(effects) {
    this.#shouldQueue = true;
    while (true) {
      for (let list4 = effects.synchronous;list4.tail; list4 = list4.tail) {
        list4.head(this.#actions);
      }
      this.#beforePaint = listAppend(this.#beforePaint, effects.before_paint);
      this.#afterPaint = listAppend(this.#afterPaint, effects.after_paint);
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
    const { patch, events } = diff(this.#events, this.#vdom, next);
    this.#events = events;
    this.#vdom = next;
    this.#reconciler.push(patch);
    if (this.#beforePaint instanceof NonEmpty) {
      const effects = makeEffect(this.#beforePaint);
      this.#beforePaint = empty_list;
      queueMicrotask(() => {
        this.#tick(effects, true);
      });
    }
    if (this.#afterPaint instanceof NonEmpty) {
      const effects = makeEffect(this.#afterPaint);
      this.#afterPaint = empty_list;
      requestAnimationFrame(() => {
        this.#tick(effects, true);
      });
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
function listAppend(a, b) {
  if (a instanceof Empty) {
    return b;
  } else if (b instanceof Empty) {
    return a;
  } else {
    return append(a, b);
  }
}
var copiedStyleSheets = new WeakMap;

// build/dev/javascript/lustre/lustre/runtime/server/runtime.mjs
class ClientDispatchedMessage extends CustomType {
  constructor(message) {
    super();
    this.message = message;
  }
}
class ClientRegisteredCallback extends CustomType {
  constructor(callback) {
    super();
    this.callback = callback;
  }
}
class ClientDeregisteredCallback extends CustomType {
  constructor(callback) {
    super();
    this.callback = callback;
  }
}
class EffectDispatchedMessage extends CustomType {
  constructor(message) {
    super();
    this.message = message;
  }
}
class EffectEmitEvent extends CustomType {
  constructor(name2, data) {
    super();
    this.name = name2;
    this.data = data;
  }
}
class EffectProvidedValue extends CustomType {
  constructor(key, value2) {
    super();
    this.key = key;
    this.value = value2;
  }
}
class SystemRequestedShutdown extends CustomType {
}

// build/dev/javascript/lustre/lustre/component.mjs
class Config2 extends CustomType {
  constructor(open_shadow_root, adopt_styles, delegates_focus, attributes, properties, contexts, is_form_associated, on_form_autofill, on_form_reset, on_form_restore) {
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
  }
}
function new$6(options) {
  let init = new Config2(true, true, false, empty_list, empty_list, empty_list, false, option_none, option_none, option_none);
  return fold(options, init, (config, option) => {
    return option.apply(config);
  });
}

// build/dev/javascript/lustre/lustre/runtime/client/spa.ffi.mjs
class Spa {
  #runtime;
  constructor(root3, [init, effects], update2, view) {
    this.#runtime = new Runtime(root3, [init, effects], view, update2);
  }
  send(message) {
    switch (message.constructor) {
      case EffectDispatchedMessage: {
        this.dispatch(message.message, false);
        break;
      }
      case EffectEmitEvent: {
        this.emit(message.name, message.data);
        break;
      }
      case SystemRequestedShutdown:
        break;
    }
  }
  dispatch(msg) {
    this.#runtime.dispatch(msg);
  }
  emit(event3, data) {
    this.#runtime.emit(event3, data);
  }
}
var start = ({ init, update: update2, view }, selector, flags) => {
  if (!is_browser())
    return new Error(new NotABrowser);
  const root3 = selector instanceof HTMLElement ? selector : document().querySelector(selector);
  if (!root3)
    return new Error(new ElementNotFound(selector));
  return new Ok(new Spa(root3, init(flags), update2, view));
};

// build/dev/javascript/lustre/lustre/runtime/server/runtime.ffi.mjs
class Runtime2 {
  #model;
  #update;
  #view;
  #config;
  #vdom;
  #events;
  #providers = new_map();
  #callbacks = /* @__PURE__ */ new Set;
  constructor([model, effects], update2, view, config) {
    this.#model = model;
    this.#update = update2;
    this.#view = view;
    this.#config = config;
    this.#vdom = this.#view(this.#model);
    this.#events = from_node(this.#vdom);
    this.#handle_effect(effects);
  }
  send(msg) {
    switch (msg.constructor) {
      case ClientDispatchedMessage: {
        const { message } = msg;
        const next = this.#handle_client_message(message);
        const diff2 = diff(this.#events, this.#vdom, next);
        this.#vdom = next;
        this.#events = diff2.events;
        this.broadcast(reconcile(diff2.patch));
        return;
      }
      case ClientRegisteredCallback: {
        const { callback } = msg;
        this.#callbacks.add(callback);
        callback(mount(this.#config.open_shadow_root, this.#config.adopt_styles, keys(this.#config.attributes), keys(this.#config.properties), keys(this.#config.contexts), this.#providers, this.#vdom));
        return;
      }
      case ClientDeregisteredCallback: {
        const { callback } = msg;
        this.#callbacks.delete(callback);
        return;
      }
      case EffectDispatchedMessage: {
        const { message } = msg;
        const [model, effect] = this.#update(this.#model, message);
        const next = this.#view(model);
        const diff2 = diff(this.#events, this.#vdom, next);
        this.#handle_effect(effect);
        this.#model = model;
        this.#vdom = next;
        this.#events = diff2.events;
        this.broadcast(reconcile(diff2.patch));
        return;
      }
      case EffectEmitEvent: {
        const { name: name2, data } = msg;
        this.broadcast(emit(name2, data));
        return;
      }
      case EffectProvidedValue: {
        const { key, value: value2 } = msg;
        const existing = map_get(this.#providers, key);
        if (existing.isOk() && isEqual2(existing[0], value2)) {
          return;
        }
        this.#providers = insert(this.#providers, key, value2);
        this.broadcast(provide(key, value2));
        return;
      }
      case SystemRequestedShutdown: {
        this.#model = null;
        this.#update = null;
        this.#view = null;
        this.#config = null;
        this.#vdom = null;
        this.#events = null;
        this.#providers = null;
        this.#callbacks.clear();
        return;
      }
      default:
        return;
    }
  }
  broadcast(msg) {
    for (const callback of this.#callbacks) {
      callback(msg);
    }
  }
  #handle_client_message(msg) {
    switch (msg.constructor) {
      case Batch: {
        const { messages } = msg;
        let model = this.#model;
        let effect = none2();
        for (let list4 = messages;list4.head; list4 = list4.tail) {
          const result = this.#handle_client_message(list4.head);
          if (result instanceof Ok) {
            model = result[0][0];
            effect = batch(List.fromArray([effect, result[0][1]]));
            break;
          }
        }
        this.#handle_effect(effect);
        this.#model = model;
        return this.#view(this.#model);
      }
      case AttributeChanged: {
        const { name: name2, value: value2 } = msg;
        const result = this.#handle_attribute_change(name2, value2);
        if (result instanceof Error) {
          return this.#vdom;
        } else {
          const [model, effects] = this.#update(this.#model, result[0]);
          this.#handle_effect(effects);
          this.#model = model;
          return this.#view(this.#model);
        }
      }
      case PropertyChanged: {
        const { name: name2, value: value2 } = msg;
        const result = this.#handle_properties_change(name2, value2);
        if (result instanceof Error) {
          return this.#vdom;
        } else {
          const [model, effects] = this.#update(this.#model, result[0]);
          this.#handle_effect(effects);
          this.#model = model;
          return this.#view(this.#model);
        }
      }
      case EventFired: {
        const { path, name: name2, event: event3 } = msg;
        const [events, result] = handle(this.#events, path, name2, event3);
        this.#events = events;
        if (result instanceof Error) {
          return this.#vdom;
        } else {
          const [model, effects] = this.#update(this.#model, result[0].message);
          this.#handle_effect(effects);
          this.#model = model;
          return this.#view(this.#model);
        }
      }
      case ContextProvided: {
        const { key, value: value2 } = msg;
        let result = map_get(this.#config.contexts, key);
        if (result instanceof Error) {
          return this.#vdom;
        }
        result = run(value2, result[0]);
        if (result instanceof Error) {
          return this.#vdom;
        }
        const [model, effects] = this.#update(this.#model, result[0]);
        this.#handle_effect(effects);
        this.#model = model;
        return this.#view(this.#model);
      }
    }
  }
  #handle_attribute_change(name2, value2) {
    const result = map_get(this.#config.attributes, name2);
    switch (result.constructor) {
      case Ok:
        return result[0](value2);
      case Error:
        return new Error(undefined);
    }
  }
  #handle_properties_change(name2, value2) {
    const result = map_get(this.#config.properties, name2);
    switch (result.constructor) {
      case Ok:
        return result[0](value2);
      case Error:
        return new Error(undefined);
    }
  }
  #handle_effect(effect) {
    const dispatch2 = (message) => this.send(new EffectDispatchedMessage(message));
    const emit2 = (name2, data) => this.send(new EffectEmitEvent(name2, data));
    const select = () => {
      return;
    };
    const internals = () => {
      return;
    };
    const provide2 = (key, value2) => this.send(new EffectProvidedValue(key, value2));
    globalThis.queueMicrotask(() => {
      perform(effect, dispatch2, emit2, select, internals, provide2);
    });
  }
}

// build/dev/javascript/lustre/lustre.mjs
class App extends CustomType {
  constructor(init, update2, view, config) {
    super();
    this.init = init;
    this.update = update2;
    this.view = view;
    this.config = config;
  }
}
class ElementNotFound extends CustomType {
  constructor(selector) {
    super();
    this.selector = selector;
  }
}
class NotABrowser extends CustomType {
}
function application(init, update2, view) {
  return new App(init, update2, view, new$6(empty_list));
}
function start3(app, selector, start_args) {
  return guard(!is_browser(), new Error(new NotABrowser), () => {
    return start(app, selector, start_args);
  });
}
// build/dev/javascript/showcase/model.mjs
class Home extends CustomType {
}
class Button extends CustomType {
}
class Icon extends CustomType {
}
class Switch extends CustomType {
}
class Model extends CustomType {
  constructor(state) {
    super();
    this.state = state;
  }
}

// build/dev/javascript/showcase/msg.mjs
class HomeSelected extends CustomType {
}
class ButtonPageSelected extends CustomType {
}
class IconPageSelected extends CustomType {
}
class SwitchPageSelected extends CustomType {
}

// build/dev/javascript/showcase/init.mjs
function init(_) {
  return [new Model(new Home), none2()];
}

// build/dev/javascript/showcase/update.mjs
function update2(_, msg) {
  if (msg instanceof HomeSelected) {
    return [new Model(new Home), none2()];
  } else if (msg instanceof ButtonPageSelected) {
    return [new Model(new Button), none2()];
  } else if (msg instanceof IconPageSelected) {
    return [new Model(new Icon), none2()];
  } else {
    return [new Model(new Switch), none2()];
  }
}

// build/dev/javascript/lustre/lustre/event.mjs
function on(name2, handler) {
  return event(name2, map2(handler, (msg) => {
    return new Handler(false, false, msg);
  }), empty_list, never, never, 0, 0);
}
function on_click(msg) {
  return on("click", success(msg));
}
// build/dev/javascript/m3e/m3e/helpers.mjs
function boolean_attribute2(name2, value2) {
  if (value2) {
    return attribute2(name2, "");
  } else {
    return none();
  }
}
function option_attribute(option, attribute_name_func, attribute_value_func, default_value) {
  if (option instanceof Some) {
    let v = option[0];
    return attribute2(attribute_name_func(v), attribute_value_func(v));
  } else {
    if (default_value instanceof Some) {
      let dv = default_value[0];
      return attribute2(attribute_name_func(dv), attribute_value_func(dv));
    } else {
      return none();
    }
  }
}

// build/dev/javascript/m3e/m3e/button.mjs
class Rounded extends CustomType {
}
class Square extends CustomType {
}
class ExtraSmall extends CustomType {
}
class Small extends CustomType {
}
class Medium extends CustomType {
}
class Large extends CustomType {
}
class ExtraLarge extends CustomType {
}
class Reset extends CustomType {
}
class Elevated extends CustomType {
}
class Filled extends CustomType {
}
class Outlined extends CustomType {
}
class Text2 extends CustomType {
}
class Tonal extends CustomType {
}
class Button2 extends CustomType {
  constructor(label2, variant, shape, size2, icons, selected_label, toggle, selected2, disabled2, type_, key, value2) {
    super();
    this.label = label2;
    this.variant = variant;
    this.shape = shape;
    this.size = size2;
    this.icons = icons;
    this.selected_label = selected_label;
    this.toggle = toggle;
    this.selected = selected2;
    this.disabled = disabled2;
    this.type_ = type_;
    this.key = key;
    this.value = value2;
  }
}
var default_shape = /* @__PURE__ */ new Rounded;
var default_size = /* @__PURE__ */ new Small;
var default_variant = /* @__PURE__ */ new Text2;
function shape_to_string(shape) {
  if (shape instanceof Rounded) {
    return "rounded";
  } else {
    return "square";
  }
}
function size_to_string(size2) {
  if (size2 instanceof ExtraSmall) {
    return "extra-small";
  } else if (size2 instanceof Small) {
    return "small";
  } else if (size2 instanceof Medium) {
    return "medium";
  } else if (size2 instanceof Large) {
    return "large";
  } else {
    return "extra-large";
  }
}
function type_to_string(t) {
  if (t instanceof Reset) {
    return "reset";
  } else {
    return "submit";
  }
}
function variant_to_string(v) {
  if (v instanceof Elevated) {
    return "elevated";
  } else if (v instanceof Filled) {
    return "filled";
  } else if (v instanceof Outlined) {
    return "outlined";
  } else if (v instanceof Text2) {
    return "text";
  } else {
    return "tonal";
  }
}
function basic(label2, variant) {
  return new Button2(label2, new Some(variant), new None, new None, toList([]), new None, false, false, false, new None, new None, new None);
}
function disabled2(b, disabled3) {
  return new Button2(b.label, b.variant, b.shape, b.size, b.icons, b.selected_label, b.toggle, b.selected, disabled3, b.type_, b.key, b.value);
}
function icons(b, icons2) {
  return new Button2(b.label, b.variant, b.shape, b.size, icons2, b.selected_label, b.toggle, b.selected, b.disabled, b.type_, b.key, b.value);
}
function selected_label(b, lab) {
  return new Button2(b.label, b.variant, b.shape, b.size, b.icons, new Some(lab), b.toggle, b.selected, b.disabled, b.type_, b.key, b.value);
}
function selected_label_elt(sl) {
  if (sl instanceof Some) {
    let lab = sl[0];
    return span(toList([attribute2("slot", "selected")]), toList([text3(lab)]));
  } else {
    return none3();
  }
}
function shape(b, s) {
  return new Button2(b.label, b.variant, new Some(s), b.size, b.icons, b.selected_label, b.toggle, b.selected, b.disabled, b.type_, b.key, b.value);
}
function size2(b, s) {
  return new Button2(b.label, b.variant, b.shape, new Some(s), b.icons, b.selected_label, b.toggle, b.selected, b.disabled, b.type_, b.key, b.value);
}
function toggle(b, t) {
  return new Button2(b.label, b.variant, b.shape, b.size, b.icons, b.selected_label, t, b.selected, b.disabled, b.type_, b.key, b.value);
}
function element4(b, attributes) {
  return element2("m3e-button", append(toList([
    option_attribute(b.variant, (_) => {
      return "variant";
    }, variant_to_string, new Some(default_variant)),
    option_attribute(b.shape, (_) => {
      return "shape";
    }, shape_to_string, new Some(default_shape)),
    option_attribute(b.size, (_) => {
      return "size";
    }, size_to_string, new Some(default_size)),
    boolean_attribute2("toggle", b.toggle),
    selected(b.selected),
    disabled(b.disabled),
    option_attribute(b.type_, (_) => {
      return "type";
    }, type_to_string, new None),
    option_attribute(b.key, (_) => {
      return "name";
    }, identity2, new None),
    option_attribute(b.value, (_) => {
      return "value";
    }, identity2, new None)
  ]), attributes), append(b.icons, toList([text3(b.label), selected_label_elt(b.selected_label)])));
}

// build/dev/javascript/m3e/m3e/card.mjs
class Horizontal extends CustomType {
}
class Vertical extends CustomType {
}
class Elevated2 extends CustomType {
}
class Filled2 extends CustomType {
}
class Outlined2 extends CustomType {
}
class Card extends CustomType {
  constructor(actionable, disabled3, inline, orientation, variant) {
    super();
    this.actionable = actionable;
    this.disabled = disabled3;
    this.inline = inline;
    this.orientation = orientation;
    this.variant = variant;
  }
}
var default_orientation = /* @__PURE__ */ new Vertical;
var default_variant2 = /* @__PURE__ */ new Filled2;
function orientation_to_string(o) {
  if (o instanceof Horizontal) {
    return "horizontal";
  } else {
    return "vertical";
  }
}
function variant_to_string2(v) {
  if (v instanceof Elevated2) {
    return "elevated";
  } else if (v instanceof Filled2) {
    return "filled";
  } else {
    return "outlined";
  }
}
function element5(c, attributes, children) {
  return element2("m3e-card", prepend(boolean_attribute2("actionable", c.actionable), prepend(boolean_attribute2("disabled", c.disabled), prepend(boolean_attribute2("inline", c.inline), prepend(attribute2("orientation", orientation_to_string(c.orientation)), prepend(attribute2("variant", variant_to_string2(c.variant)), attributes))))), children);
}
function variant(c, v) {
  return new Card(c.actionable, c.disabled, c.inline, c.orientation, v);
}
function basic2() {
  return new Card(false, false, false, default_orientation, default_variant2);
}

// build/dev/javascript/m3e/m3e/drawer.mjs
class Auto extends CustomType {
}
class Over extends CustomType {
}
class Push extends CustomType {
}
class Start extends CustomType {
}
class End extends CustomType {
}
class Vacant extends CustomType {
}
class Drawer extends CustomType {
  constructor(usage, mode, open, id2, divider, content) {
    super();
    this.usage = usage;
    this.mode = mode;
    this.open = open;
    this.id = id2;
    this.divider = divider;
    this.content = content;
  }
}
function mode_to_string(m) {
  if (m instanceof Auto) {
    return "auto";
  } else if (m instanceof Over) {
    return "over";
  } else if (m instanceof Push) {
    return "push";
  } else {
    return "side";
  }
}
function drawer(usage, mode, open, id2, divider, content) {
  return new Drawer(usage, mode, open, id2, divider, content);
}
function element6(dc) {
  let _block;
  let $ = string_length(dc.id);
  if ($ === 0) {
    _block = none();
  } else {
    _block = attribute2("id", dc.id);
  }
  let id$1 = _block;
  let _block$1;
  let $1 = dc.usage;
  if ($1 instanceof Start) {
    _block$1 = toList([
      boolean_attribute2("start", dc.open),
      boolean_attribute2("start-divider", dc.divider),
      attribute2("start-mode", mode_to_string(dc.mode))
    ]);
  } else if ($1 instanceof End) {
    _block$1 = toList([
      boolean_attribute2("end", dc.open),
      boolean_attribute2("end-divider", dc.divider),
      attribute2("end-mode", mode_to_string(dc.mode))
    ]);
  } else {
    _block$1 = toList([none()]);
  }
  let attributes = _block$1;
  let _block$2;
  let $2 = dc.usage;
  if ($2 instanceof Start) {
    _block$2 = div(toList([attribute2("slot", "start"), id$1]), toList([dc.content]));
  } else if ($2 instanceof End) {
    _block$2 = div(toList([attribute2("slot", "end"), id$1]), toList([dc.content]));
  } else {
    _block$2 = none3();
  }
  let elt = _block$2;
  return [attributes, elt];
}
function empty3() {
  return new Drawer(new Vacant, new Auto, false, "", false, none3());
}

// build/dev/javascript/m3e/m3e/drawer_container.mjs
class DrawerContainer extends CustomType {
  constructor(start4, main, end) {
    super();
    this.start = start4;
    this.main = main;
    this.end = end;
  }
}
function drawer_container(start4, main, end) {
  return new DrawerContainer(start4, main, end);
}
function element7(c, attributes) {
  let $ = element6(c.start);
  let start_attrs;
  let start_drawer;
  start_attrs = $[0];
  start_drawer = $[1];
  let $1 = element6(c.end);
  let end_attrs;
  let end_drawer;
  end_attrs = $1[0];
  end_drawer = $1[1];
  return element2("m3e-drawer-container", (() => {
    let _pipe = append(start_attrs, end_attrs);
    return append(_pipe, attributes);
  })(), toList([start_drawer, c.main, end_drawer]));
}

// build/dev/javascript/m3e/m3e/drawer_toggle.mjs
class DrawerToggle extends CustomType {
  constructor(for$2) {
    super();
    this.for = for$2;
  }
}
function drawer_toggle(for$2) {
  return new DrawerToggle(for$2);
}
function element8(c, attributes, children) {
  return element2("m3e-drawer-toggle", prepend(for$(c.for), attributes), children);
}

// build/dev/javascript/m3e/m3e/icon.mjs
class Low extends CustomType {
}
class Medium2 extends CustomType {
}
class Avatar extends CustomType {
}
class Default extends CustomType {
}
class Leading extends CustomType {
}
class LeadingIcon extends CustomType {
}
class Selected extends CustomType {
}
class Trailing extends CustomType {
}
class Outlined3 extends CustomType {
}
class Rounded2 extends CustomType {
}
class Icon2 extends CustomType {
  constructor(name2, filled, grade, optical_size, purpose, variant2, weight) {
    super();
    this.name = name2;
    this.filled = filled;
    this.grade = grade;
    this.optical_size = optical_size;
    this.purpose = purpose;
    this.variant = variant2;
    this.weight = weight;
  }
}
var default_grade = /* @__PURE__ */ new Medium2;
var default_optical_size = 24;
var default_purpose = /* @__PURE__ */ new Default;
var default_variant3 = /* @__PURE__ */ new Outlined3;
var default_weight = 400;
function grade_to_string(grade) {
  if (grade instanceof Low) {
    return "low";
  } else if (grade instanceof Medium2) {
    return "medium";
  } else {
    return "high";
  }
}
function purpose_to_string(purpose) {
  if (purpose instanceof Avatar) {
    return "avatar";
  } else if (purpose instanceof Default) {
    return "icon";
  } else if (purpose instanceof Leading) {
    return "leading";
  } else if (purpose instanceof LeadingIcon) {
    return "leading-icon";
  } else if (purpose instanceof Selected) {
    return "selected";
  } else if (purpose instanceof Trailing) {
    return "trailing";
  } else {
    return "trailing-icon";
  }
}
function variant_to_string3(variant2) {
  if (variant2 instanceof Outlined3) {
    return "outlined";
  } else if (variant2 instanceof Rounded2) {
    return "rounded";
  } else {
    return "sharp";
  }
}
function filled_attr(f) {
  if (f) {
    return attribute2("filled", "1");
  } else {
    return attribute2("filled", "0");
  }
}
function grade_attr(g) {
  return attribute2("grade", grade_to_string(g));
}
function optical_size_attr(os) {
  return attribute2("optical-size", to_string(os));
}
function purpose(i, p2) {
  return new Icon2(i.name, i.filled, i.grade, i.optical_size, p2, i.variant, i.weight);
}
function purpose_attr(p2) {
  return attribute2("slot", purpose_to_string(p2));
}
function variant_attr(v) {
  return attribute2("variant", variant_to_string3(v));
}
function weight_attr(w) {
  return attribute2("weight", to_string(w));
}
function element9(i, attributes, children) {
  return element2("m3e-icon", append(toList([
    name(i.name),
    filled_attr(i.filled),
    grade_attr(i.grade),
    optical_size_attr(i.optical_size),
    purpose_attr(i.purpose),
    variant_attr(i.variant),
    weight_attr(i.weight)
  ]), attributes), children);
}
function basic3(name2) {
  return new Icon2(name2, false, default_grade, default_optical_size, default_purpose, default_variant3, default_weight);
}

// build/dev/javascript/m3e/m3e/icon_button.mjs
class LeadingIcon2 extends CustomType {
}
class TrailingButton extends CustomType {
}
class Rounded3 extends CustomType {
}
class ExtraSmall2 extends CustomType {
}
class Small2 extends CustomType {
}
class Medium3 extends CustomType {
}
class Large2 extends CustomType {
}
class Button3 extends CustomType {
}
class Submit extends CustomType {
}
class Filled3 extends CustomType {
}
class Tonal2 extends CustomType {
}
class Outlined4 extends CustomType {
}
class Standard extends CustomType {
}
class Default2 extends CustomType {
}
class Narrow extends CustomType {
}
class IconButton extends CustomType {
  constructor(disabled3, disabled_interactive, key, purpose2, selected2, shape2, size3, toggle2, type_, value2, variant2, width) {
    super();
    this.disabled = disabled3;
    this.disabled_interactive = disabled_interactive;
    this.key = key;
    this.purpose = purpose2;
    this.selected = selected2;
    this.shape = shape2;
    this.size = size3;
    this.toggle = toggle2;
    this.type_ = type_;
    this.value = value2;
    this.variant = variant2;
    this.width = width;
  }
}
var default_shape2 = /* @__PURE__ */ new Rounded3;
var default_size2 = /* @__PURE__ */ new Small2;
var default_type = /* @__PURE__ */ new Button3;
var default_variant4 = /* @__PURE__ */ new Standard;
var default_width = /* @__PURE__ */ new Default2;
function purpose_to_string2(purpose2) {
  if (purpose2 instanceof LeadingIcon2) {
    return "leading-icon";
  } else if (purpose2 instanceof TrailingButton) {
    return "trailing-button";
  } else {
    return "trailing-icon";
  }
}
function shape_to_string2(s) {
  if (s instanceof Rounded3) {
    return "rounded";
  } else {
    return "square";
  }
}
function size_to_string2(s) {
  if (s instanceof ExtraSmall2) {
    return "extra-small";
  } else if (s instanceof Small2) {
    return "small";
  } else if (s instanceof Medium3) {
    return "medium";
  } else if (s instanceof Large2) {
    return "large";
  } else {
    return "extra-large";
  }
}
function type_to_string2(t) {
  if (t instanceof Button3) {
    return "button";
  } else if (t instanceof Submit) {
    return "submit";
  } else {
    return "reset";
  }
}
function variant_to_string4(v) {
  if (v instanceof Filled3) {
    return "filled";
  } else if (v instanceof Tonal2) {
    return "tonal";
  } else if (v instanceof Outlined4) {
    return "outlined";
  } else {
    return "standard";
  }
}
function width_to_string(w) {
  if (w instanceof Default2) {
    return "default";
  } else if (w instanceof Narrow) {
    return "narrow";
  } else {
    return "wide";
  }
}
function purpose2(i, purpose3) {
  return new IconButton(i.disabled, i.disabled_interactive, i.key, purpose3, i.selected, i.shape, i.size, i.toggle, i.type_, i.value, i.variant, i.width);
}
function toggle2(i, toggle3) {
  return new IconButton(i.disabled, i.disabled_interactive, i.key, i.purpose, i.selected, i.shape, i.size, toggle3, i.type_, i.value, i.variant, i.width);
}
function variant2(i, variant3) {
  return new IconButton(i.disabled, i.disabled_interactive, i.key, i.purpose, i.selected, i.shape, i.size, i.toggle, i.type_, i.value, variant3, i.width);
}
function element10(i, attributes, children) {
  return element2("m3e-icon-button", prepend(disabled(i.disabled), prepend(boolean_attribute2("disabled-interactive", i.disabled_interactive), prepend(attribute2("key", i.key), prepend(option_attribute(i.purpose, (_) => {
    return "slot";
  }, purpose_to_string2, new None), prepend(selected(i.selected), prepend(attribute2("shape", shape_to_string2(i.shape)), prepend(attribute2("size", size_to_string2(i.size)), prepend(boolean_attribute2("toggle", i.toggle), prepend(attribute2("type", type_to_string2(i.type_)), prepend(value(i.value), prepend(attribute2("variant", variant_to_string4(i.variant)), prepend(attribute2("width", width_to_string(i.width)), attributes)))))))))))), children);
}
function basic4() {
  return new IconButton(false, false, "", new None, false, default_shape2, default_size2, false, default_type, "", default_variant4, default_width);
}

// build/dev/javascript/m3e/m3e/switch.mjs
class Both extends CustomType {
}
class Neither extends CustomType {
}
class Switch2 extends CustomType {
  constructor(id2, label2, icons2, checked, disabled3, key, value2) {
    super();
    this.id = id2;
    this.label = label2;
    this.icons = icons2;
    this.checked = checked;
    this.disabled = disabled3;
    this.key = key;
    this.value = value2;
  }
}
function icons_to_string(i) {
  if (i instanceof Both) {
    return "both";
  } else if (i instanceof Neither) {
    return "none";
  } else {
    return "selected";
  }
}
function basic5(id2, label2) {
  return new Switch2(id2, label2, new Neither, false, false, new None, new None);
}
function icon_attr(i) {
  return attribute2("icons", icons_to_string(i));
}
function element11(s, attributes) {
  return toList([
    element2("m3e-switch", append(toList([
      id(s.id),
      icon_attr(s.icons),
      boolean_attribute2("checked", s.checked),
      boolean_attribute2("disabled", s.disabled),
      option_attribute(s.key, (_) => {
        return "name";
      }, identity2, new None),
      option_attribute(s.value, (_) => {
        return "value";
      }, identity2, new None)
    ]), attributes), toList([])),
    label(toList([for$(s.id)]), toList([text2(s.label)]))
  ]);
}

// build/dev/javascript/m3e/m3e/theme.mjs
class High extends CustomType {
}
class Medium4 extends CustomType {
}
class StandardContrast extends CustomType {
}
class Expressive extends CustomType {
}
class Standard2 extends CustomType {
}
class Auto2 extends CustomType {
}
class Dark extends CustomType {
}
class Theme extends CustomType {
  constructor(color, contrast, density, motion, scheme, strong_focus) {
    super();
    this.color = color;
    this.contrast = contrast;
    this.density = density;
    this.motion = motion;
    this.scheme = scheme;
    this.strong_focus = strong_focus;
  }
}
var default_contrast = /* @__PURE__ */ new StandardContrast;
var default_density = 0;
var default_motion = /* @__PURE__ */ new Standard2;
var default_scheme = /* @__PURE__ */ new Auto2;
function contrast_to_string(c) {
  if (c instanceof High) {
    return "high";
  } else if (c instanceof Medium4) {
    return "medium";
  } else {
    return "standard";
  }
}
function motion_to_string(m) {
  if (m instanceof Expressive) {
    return "expressive";
  } else {
    return "standard";
  }
}
function scheme_to_string(s) {
  if (s instanceof Auto2) {
    return "auto";
  } else if (s instanceof Dark) {
    return "dark";
  } else {
    return "light";
  }
}
function color(t, hex_color) {
  let $ = is_empty2(hex_color);
  if ($) {
    return t;
  } else {
    return new Theme(hex_color, t.contrast, t.density, t.motion, t.scheme, t.strong_focus);
  }
}
function color_attr(color2) {
  return attribute2("color", color2);
}
function contrast_attr(contrast) {
  return attribute2("contrast", contrast_to_string(contrast));
}
function density_attr(density) {
  return attribute2("density", to_string(density));
}
function motion_attr(motion) {
  return attribute2("motion", motion_to_string(motion));
}
function scheme_attr(scheme) {
  return attribute2("scheme", scheme_to_string(scheme));
}
function element12(t, attributes, children) {
  return element2("m3e-theme", prepend(color_attr(t.color), prepend(contrast_attr(t.contrast), prepend(density_attr(t.density), prepend(motion_attr(t.motion), prepend(scheme_attr(t.scheme), prepend(boolean_attribute2("strong-focus", t.strong_focus), attributes)))))), children);
}
function basic6(color2) {
  return new Theme(color2, default_contrast, default_density, default_motion, default_scheme, false);
}

// build/dev/javascript/showcase/view.mjs
function home() {
  return div(toList([]), toList([
    text3("home"),
    br(toList([])),
    div(toList([on_click(new ButtonPageSelected)]), toList([text3("Button")])),
    br(toList([])),
    div(toList([on_click(new IconPageSelected)]), toList([text3("Icon")])),
    br(toList([])),
    div(toList([on_click(new SwitchPageSelected)]), toList([text3("Switch")]))
  ]));
}
function icon() {
  return div(toList([]), toList([
    div(toList([on_click(new HomeSelected)]), toList([text3("Home")])),
    br(toList([])),
    div(toList([]), toList([
      (() => {
        let _pipe = basic3("home");
        return element9(_pipe, toList([]), toList([]));
      })()
    ])),
    br(toList([]))
  ]));
}
function button() {
  return div(toList([class$("grid grid-cols-[5fr_5fr_5fr] gap-5")]), toList([
    (() => {
      let _pipe = basic("Home", new Outlined);
      return element4(_pipe, toList([class$("col-2"), on_click(new HomeSelected)]));
    })(),
    div(toList([
      class$("grid grid-rows-1 grid-cols-[1fr_1fr_1fr_1fr_1fr_1fr] items-center  gap-5 col-2")
    ]), toList([
      p(toList([]), toList([text3("Variants")])),
      (() => {
        let _pipe = basic("Elevated", new Elevated);
        return element4(_pipe, toList([]));
      })(),
      (() => {
        let _pipe = basic("Filled", new Filled);
        return element4(_pipe, toList([]));
      })(),
      (() => {
        let _pipe = basic("Tonal", new Tonal);
        return element4(_pipe, toList([]));
      })(),
      (() => {
        let _pipe = basic("Outlined", new Outlined);
        return element4(_pipe, toList([]));
      })(),
      (() => {
        let _pipe = basic("Text", new Text2);
        return element4(_pipe, toList([]));
      })()
    ])),
    div(toList([
      class$("grid grid-rows-1 grid-cols-4 items-center  gap-5 col-2")
    ]), toList([
      p(toList([]), toList([text3("Shapes")])),
      (() => {
        let _pipe = basic("Rounded Filled", new Filled);
        return element4(_pipe, toList([class$("justify-self-center")]));
      })(),
      (() => {
        let _pipe = basic("Square Filled", new Filled);
        let _pipe$1 = shape(_pipe, new Square);
        return element4(_pipe$1, toList([class$("justify-self-center")]));
      })()
    ])),
    div(toList([
      class$("grid grid-rows-1 grid-cols-[1fr_1fr_1fr_1fr_1fr_1fr] items-center gap-5 col-2")
    ]), toList([
      p(toList([]), toList([text3("Sizes")])),
      (() => {
        let _pipe = basic("Extra Small", new Tonal);
        let _pipe$1 = size2(_pipe, new ExtraSmall);
        return element4(_pipe$1, toList([]));
      })(),
      (() => {
        let _pipe = basic("Small", new Tonal);
        let _pipe$1 = size2(_pipe, new Small);
        return element4(_pipe$1, toList([]));
      })(),
      (() => {
        let _pipe = basic("Medium", new Tonal);
        let _pipe$1 = size2(_pipe, new Medium);
        return element4(_pipe$1, toList([]));
      })(),
      (() => {
        let _pipe = basic("Large", new Tonal);
        let _pipe$1 = size2(_pipe, new Large);
        return element4(_pipe$1, toList([]));
      })(),
      (() => {
        let _pipe = basic("Extra Large", new Tonal);
        let _pipe$1 = size2(_pipe, new ExtraLarge);
        return element4(_pipe$1, toList([]));
      })()
    ])),
    div(toList([class$("grid grid-rows-1 grid-cols-4 items-center gap-5 col-2")]), toList([
      p(toList([]), toList([text3("Icons")])),
      (() => {
        let _pipe = basic("Send", new Tonal);
        let _pipe$1 = icons(_pipe, toList([
          (() => {
            let _pipe$12 = basic3("send");
            return element9(_pipe$12, toList([]), toList([]));
          })()
        ]));
        return element4(_pipe$1, toList([class$("justify-self-center")]));
      })(),
      (() => {
        let _pipe = basic("Open", new Tonal);
        let _pipe$1 = icons(_pipe, toList([
          (() => {
            let _pipe$12 = basic3("open_in_new_window");
            let _pipe$2 = purpose(_pipe$12, new Trailing);
            return element9(_pipe$2, toList([]), toList([]));
          })()
        ]));
        return element4(_pipe$1, toList([class$("justify-self-center")]));
      })()
    ])),
    div(toList([class$("grid grid-rows-1 grid-cols-4 items-center gap-5 col-2")]), toList([
      p(toList([]), toList([text3("Toggle")])),
      (() => {
        let _pipe = basic("Tonal toggle", new Tonal);
        let _pipe$1 = toggle(_pipe, true);
        return element4(_pipe$1, toList([class$("justify-self-center")]));
      })(),
      (() => {
        let _pipe = basic("Start", new Tonal);
        let _pipe$1 = toggle(_pipe, true);
        let _pipe$2 = icons(_pipe$1, toList([
          (() => {
            let _pipe$22 = basic3("play_arrow");
            return element9(_pipe$22, toList([]), toList([]));
          })(),
          (() => {
            let _pipe$22 = basic3("stop");
            let _pipe$32 = purpose(_pipe$22, new Selected);
            return element9(_pipe$32, toList([]), toList([]));
          })()
        ]));
        let _pipe$3 = selected_label(_pipe$2, "Stop");
        return element4(_pipe$3, toList([class$("justify-self-center")]));
      })()
    ])),
    div(toList([class$("grid grid-rows-1 grid-cols-4 items-center gap-5 col-2")]), toList([
      p(toList([]), toList([text3("Disabling")])),
      (() => {
        let _pipe = basic("Disabled", new Filled);
        let _pipe$1 = disabled2(_pipe, true);
        return element4(_pipe$1, toList([class$("justify-self-center")]));
      })(),
      (() => {
        let _pipe = basic("Disabled interactive", new Filled);
        let _pipe$1 = disabled2(_pipe, true);
        return element4(_pipe$1, toList([class$("justify-self-center")]));
      })()
    ])),
    div(toList([class$("grid grid-rows-1 grid-cols-4 items-center gap-5 col-2")]), toList([
      p(toList([]), toList([text3("Links")])),
      (() => {
        let _pipe = basic("Google", new Tonal);
        let _pipe$1 = icons(_pipe, toList([
          (() => {
            let _pipe$12 = basic3("open_in_new_window");
            let _pipe$2 = purpose(_pipe$12, new Trailing);
            return element9(_pipe$2, toList([]), toList([]));
          })()
        ]));
        return element4(_pipe$1, toList([
          class$("justify-self-center"),
          href("https://google.com"),
          target("_blank")
        ]));
      })()
    ]))
  ]));
}
function switch_() {
  return div(toList([]), toList([
    div(toList([on_click(new HomeSelected)]), toList([text3("Home")])),
    br(toList([])),
    div(toList([]), (() => {
      let _pipe = basic5("my-switch", "My choice");
      return element11(_pipe, toList([]));
    })()),
    br(toList([]))
  ]));
}
function view(model) {
  let _block;
  let $ = model.state;
  if ($ instanceof Home) {
    _block = home();
  } else if ($ instanceof Button) {
    _block = button();
  } else if ($ instanceof Icon) {
    _block = icon();
  } else {
    _block = switch_();
  }
  let main = _block;
  let title = div(toList([class$("grid justify-center")]), toList([text3("Gleam/Lustre Material 3 Expression demonstration")]));
  let body = toList([
    (() => {
      let _pipe = basic2();
      let _pipe$1 = variant(_pipe, new Outlined2);
      return element5(_pipe$1, toList([]), toList([
        div(toList([attribute2("slot", "content")]), toList([
          (() => {
            let _pipe$2 = basic4();
            let _pipe$3 = toggle2(_pipe$2, true);
            let _pipe$4 = purpose2(_pipe$3, new Some(new LeadingIcon2));
            let _pipe$5 = variant2(_pipe$4, new Filled3);
            return element10(_pipe$5, toList([]), toList([
              (() => {
                let _pipe$6 = basic3("menu");
                return element9(_pipe$6, toList([]), toList([]));
              })(),
              (() => {
                let _pipe$6 = basic3("menu_open");
                let _pipe$7 = purpose(_pipe$6, new Selected);
                return element9(_pipe$7, toList([]), toList([]));
              })(),
              (() => {
                let _pipe$6 = drawer_toggle("nav-drawer");
                return element8(_pipe$6, toList([]), toList([]));
              })()
            ]));
          })(),
          (() => {
            let _pipe$2 = drawer_container(drawer(new Start, new Over, true, "nav-drawer", false, text3("Start drawer")), main, empty3());
            return element7(_pipe$2, toList([]));
          })()
        ]))
      ]));
    })()
  ]);
  return element12((() => {
    let _pipe = basic6("app-theme");
    return color(_pipe, "#09022e");
  })(), toList([]), prepend(title, body));
}

// build/dev/javascript/showcase/app.mjs
var FILEPATH = "src/app.gleam";
function main() {
  let app = application(init, update2, view);
  let $ = start3(app, "#app", undefined);
  if (!($ instanceof Ok)) {
    throw makeError("let_assert", FILEPATH, "app", 8, "main", "Pattern match failed, no pattern matched the value.", { value: $, start: 145, end: 194, pattern_start: 156, pattern_end: 161 });
  }
  return;
}

// .lustre/build/app.mjs
main();
