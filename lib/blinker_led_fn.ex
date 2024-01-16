defmodule BlinkerLedFn do
  @moduledoc """
  What the DtsBuddy API could look like if we go forward with EEx
  The template string allows the user to abstract a bit and decouple
  the actual DTS definition from its configuration (which pin, which pattern),
  which would allow to use standard config to pass values.
  """
  def setup(options \\ [pattern: "<1 500 1 0 0 500 0 0>"]) do
    template = """
      /dts-v1/;
      /plugin/;

      &{/} {
        leds {
          compatible = "gpio-leds";

          test_led@36 {
            label = "test-led1";
            gpios = <&pio 1 4 0>; /* GPIO36/PB4 */

            /* Blink LED at 1 Hz (500 ms on, off) */
            linux,default-trigger = "pattern";
            led-pattern = <%= pattern %>;
          };
        };
      };
    """

    DtsBuddy.compile_dts(template, options, "test_led")
      |> DtsBuddy.load()
  end
end
