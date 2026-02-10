import gleeunit/should
import m3e/form_submission.{FormSubmission, Reset, Submit}

pub fn new_test() {
  form_submission.new()
  |> should.equal(FormSubmission(form_submission.default_form_submitter_type, "", ""))
}

pub fn type_test() {
  form_submission.new()
  |> form_submission.type_(Submit)
  |> should.equal(FormSubmission(Submit, "", ""))

  form_submission.new()
  |> form_submission.type_(Reset)
  |> should.equal(FormSubmission(Reset, "", ""))
}

pub fn name_test() {
  form_submission.new()
  |> form_submission.name("test-name")
  |> should.equal(FormSubmission(form_submission.default_form_submitter_type, "test-name", ""))
}

pub fn value_test() {
  form_submission.new()
  |> form_submission.value("test-value")
  |> should.equal(FormSubmission(form_submission.default_form_submitter_type, "", "test-value"))
}

pub fn pipeline_test() {
  form_submission.new()
  |> form_submission.type_(Submit)
  |> form_submission.name("test-name")
  |> form_submission.value("test-value")
  |> should.equal(FormSubmission(Submit, "test-name", "test-value"))
}
