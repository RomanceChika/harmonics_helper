require "matrix"
require "harmonics_helper/code/code_base"

module HarmonicsHelper

  module Code

    # deal with rotation of code
    class Rotations < CodeBase

      # get rotation types, basic first, etc
      # if it has not　form of code, apply ""
      # 
      # @return [Array] rotations
      def rotation_types
        # basso continuos array
        basso_continuos = @full_harmonies.map{ |harmony| harmony.map{ |part| degree_from_bass(part, bass(harmony)) }.uniq.sort }
        basso_continuos.map{ |basso_continuo| rotation_hash.has_key?(basso_continuo) ? rotation_hash[basso_continuo] : "" }
      end

    end

  end

end
