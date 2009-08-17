class SimpleTidy

  def initialize
  end

  def clean html
    `echo '#{ html }' | tidy --tidy-mark false`.strip # todo: use popen to get stderr/out
  end

end
