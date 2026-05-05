export function attach_change_handler(picker_id, input_id) {
  const picker = document.querySelector(picker_id);
  const input = document.querySelector(input_id);
  picker.addEventListener("change", () => {
    input.value = picker.date.toLocaleDateString();
  });
}
