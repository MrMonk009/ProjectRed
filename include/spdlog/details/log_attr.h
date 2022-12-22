#pragma once

#include <string>
#include <string_view>
#include <concepts>
#include "attr_composer.h"

namespace spdlog {
namespace details {

//template<typename T>
//concept composable = std::same_as<T, bool> || std::integral<T> || std::floating_point<T> || std::convertible_to<T, std::string_view>;

struct attr
{
    std::string key;
    std::string value;

public:
    attr(std::initializer_list<std::string_view> l) {
        if (l.size() != 2) return; // throw exception if not kv pair?

        scramble(key, *l.begin());
        scramble(value, *(l.begin()+1));
    }

    attr(std::string_view k, bool v)
        : key{k}
        , value{v ? "true" : "false"}
    {}

    attr(std::string_view k, std::string_view v)
        : key{k}
        , value{v}
    {}

    template <typename T>
    attr(std::string_view k, T const &v)
        : key{k}
        , value{std::to_string(v)}
    {}
};

} // namespace details
} // namespace spdlog