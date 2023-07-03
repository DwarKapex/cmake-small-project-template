# set the C++ standard to use
add_compile_options(
        -Wcast-align
        -Wcast-qual
        -Wdeprecated
        -Wdisabled-optimization
        -Wimplicit-fallthrough
        -Winit-self
        -Wmissing-include-dirs
        -Wnon-virtual-dtor
        -Wnull-dereference
        -Woverloaded-virtual
        -Wpessimizing-move
        -Wpointer-arith
        -Wredundant-decls
        -Wredundant-move
        -Wsign-promo
        -Wuninitialized
        -Wunreachable-code
)

# clang recomendations
if (${CMAKE_CXX_COMPILER} MATCHES ".*clang.*")
        add_compile_options(
            -Wbool-conversion
            -Wdeprecated-implementations
            -Wduplicate-method-match
            -Wempty-body
            -Wenum-conversion
            -Wextra-semi
            -Winfinite-recursion
            -Wmacro-redefined
            -Wmove
            -Wnon-literal-null-conversion
            -Wrange-loop-analysis
            -Wstrict-prototypes
            -Wunreachable-code
        )
endif()