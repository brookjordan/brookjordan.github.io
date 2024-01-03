const DEFAULT_INITIAL_POSITION = 0;
const DEFAULT_INITIAL_VELOCITY = 10;
const DEFAULT_FRICTION = 0.01;

export function willBeAt(
  frameNumber,
  {
    initialPosition = DEFAULT_INITIAL_POSITION,
    initialVelocity = DEFAULT_INITIAL_VELOCITY,
    friction = DEFAULT_FRICTION,
  } = {}
) {
  return (
    initialPosition +
    initialVelocity * ((1 - (1 - friction) ** frameNumber) / friction)
  );
}

export function willLandAt({
  initialPosition = DEFAULT_INITIAL_POSITION,
  initialVelocity = DEFAULT_INITIAL_VELOCITY,
  friction = DEFAULT_FRICTION,
} = {}) {
  return initialPosition + initialVelocity / friction;
}

export function frictionRequiredToLandAt({
  initialPosition = DEFAULT_INITIAL_POSITION,
  initialVelocity = DEFAULT_INITIAL_VELOCITY,
  finalLanding = DEFAULT_FRICTION,
}) {
  return initialVelocity / (finalLanding - initialPosition);
}
