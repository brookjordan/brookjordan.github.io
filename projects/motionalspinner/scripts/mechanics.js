export function willBeAt(i) {
  const t =
    arguments.length <= 1 || void 0 === arguments[1] ? {} : arguments[1];
  const o = t.initialPosition;
  const n = void 0 === o ? 0 : o;
  const e = t.initialVelocity;
  const l = void 0 === e ? 10 : e;
  const d = t.friction;
  const r = void 0 === d ? 0.01 : d;
  return n + l * ((1 - (1 - r) ** i) / r);
}

export function willLandAt(...args) {
  const i = args.length <= 0 || void 0 === args[0] ? {} : args[0];
  const t = i.initialPosition;
  const o = void 0 === t ? 0 : t;
  const n = i.initialVelocity;
  const e = void 0 === n ? 10 : n;
  const l = i.friction;
  const d = void 0 === l ? 0.01 : l;
  return o + e / d;
}

export function frictionRequiredToLandAt(...args) {
  const i = args.length <= 0 || void 0 === args[0] ? {} : args[0];
  const t = i.initialPosition;
  const o = void 0 === t ? 0 : t;
  const n = i.initialVelocity;
  const e = void 0 === n ? 10 : n;
  const l = i.finalLanding;
  const d = void 0 === l ? 1e3 : l;
  return e / (d - o);
}
