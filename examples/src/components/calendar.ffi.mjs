export function date(id) {
  const calendar = document.querySelector(`#${id}`);
  if (calendar === null) return "calendar is null";
  const date = calendar.date;
  const day = date.getDate();
  const month = date.getMonth() + 1;
  const year = date.getFullYear();
  return (
    year.toString() +
    "-" +
    month.toString().padStart(2, "0") +
    "-" +
    day.toString().padStart(2, "0")
  );
}

export function is_blackout_date(date) {
  const d = new Date(date);
  const day = d.getDay();
  const blackout = day % 6 === 0;
  return blackout;
}

export function attach_blackout_func(selector) {
  // We use a selector to find the element after Lustre renders it
  const el = document.querySelector(selector);
  if (el) {
    // Manually attach the function to the DOM property
    el.blackoutDates = (date) =>
      // 'date' here is a JS Date object from the M3E component
      is_blackout_date(date);
  }
}
