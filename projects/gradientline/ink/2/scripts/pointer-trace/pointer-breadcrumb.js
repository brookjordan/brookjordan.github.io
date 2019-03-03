let previousBreadcrumbDate = +new Date();

class HistoryBreadcrumb {
  constructor(event) {
    this.type      = event.type;
    this.pause     = +new Date() - previousBreadcrumbDate;
    this.timeStamp = previousBreadcrumbDate = previousBreadcrumbDate + this.pause;

    this.points = event.touches
      ? event.touches.map(touch => new FauxTouch(touch))
      : [new FauxTouch(event)];

    this.x = this.points[0].x;
    this.y = this.points[0].y;
  }
}

class FauxTouch {
  constructor(touchOrEvent) {
    this.x = touchOrEvent.clientX;
    this.y = touchOrEvent.clientY;
  }
}

export default HistoryBreadcrumb;
