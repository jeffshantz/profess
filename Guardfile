
guard_cucumber_opts = {
  cli: '--color --strict',
  all_after_pass: false,
  all_on_start: false,
  change_format: 'pretty',
  focus_on: 'focus' 
}

guard 'cucumber', guard_cucumber_opts do
  watch(%r{^features/.+\.feature$})
  watch(%r{^features/support/.+$})          { 'features' }
  watch(%r{^features/step_definitions/(.+)_steps\.rb$}) { |m| Dir[File.join("**/#{m[1]}.feature")][0] || 'features' }
end

guard_rspec_opts = {
  cli: '--color --format documentation',
  all_after_pass: false,
  all_on_start: false
}

guard :rspec, guard_rspec_opts do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/profess/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')  { "spec" }
end

