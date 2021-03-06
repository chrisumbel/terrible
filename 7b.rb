require 'rubygems'
require 'bitescript'
import java.lang.System
import java.io.PrintStream

include BiteScript

fb = FileBuilder.build(__FILE__) do
  public_class "Seven" do
    public_static_method "foo", [], int, int, int do
      iload 0
      iload 1
      iadd
      ireturn
    end

    public_static_method "main", [], void, string[] do
      getstatic System, :out, PrintStream
      ldc "result is "
      invokevirtual PrintStream, "print", [void, string]

      getstatic System, :out, PrintStream
      ldc 6
      ldc 9
      invokestatic this, "foo", [int, int, int]
      invokevirtual PrintStream, "print", [void, int]

      getstatic System, :out, PrintStream
      invokevirtual PrintStream, "println", [void]
      returnvoid
    end
  end
end

fb.generate do |filename, class_builder|
  File.open(filename, 'w') do |file|
    file.write(class_builder.generate)
  end
end
