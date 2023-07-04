#pragma once

#include <cstdint>

namespace tools {
/**
 * \brief Calculate the factorial of N in compile time
 *
 * \tparam N Value to calculate factorial of
 */
template <int N>
struct Factorial {
  static_assert(N >= 0 && "Factorial of negative value is unknown");
  static constexpr uint32_t value = N * Factorial<N - 1>::value;
};

/**
 * \brief Base case to stop templates generation
 */
template <>
struct Factorial<0> {
  static constexpr uint32_t value = 1;
};

} // namespace tools
