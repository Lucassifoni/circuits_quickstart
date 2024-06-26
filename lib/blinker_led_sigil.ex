defmodule BlinkerLedSigil do
  @moduledoc """
  What the DtsBuddy API could look like with the new multi-letter sigil support.
  What I liked is the (near) absence of syntax after you `import DtsBuddy`, but
  the multi-letter sigils do not support interpolation in strings, and interpolating
  the DTS string ourselves will either add macros or calling conventions.
  To me it was a nice to have, but not essential.
  """

  import DtsBuddy.Sigil

  def setup() do
    DtsBuddy.enable_overlays()

    ~DTS"""
      /dts-v1/;
      /plugin/;

      &{/} {
        gpios_leds {
          compatible = "gpio-leds";

          test_led@36 {
            label = "test-led1";
            gpios = <&pio 1 4 0>; /* GPIO36/PB4 */

            /* Blink LED at 1 Hz (500 ms on, off) */
            linux,default-trigger = "pattern";
            led-pattern = <1 500 1 0 0 500 0 0>;
          };
        };
      };
    """led |> DtsBuddy.load()
  end
end
