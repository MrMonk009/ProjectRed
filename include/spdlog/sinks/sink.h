//
// Copyright(c) 2015 Gabi Melman.
// Distributed under the MIT License (http://opensource.org/licenses/MIT)
//


#pragma once

#include "../details/log_msg.h"
#include "../formatter.h"

#include <memory>

namespace spdlog
{
namespace sinks
{
class sink
{
public:
    sink():
        _formatter(nullptr)
    {
        _level = level::trace;
    }

    virtual ~sink() {}
    virtual void log(const details::log_msg& msg) = 0;
    virtual void flush() = 0;

    bool should_log(level::level_enum msg_level) const;
    void set_level(level::level_enum log_level);
    level::level_enum level() const;

    void set_pattern(const std::string& pattern, pattern_time_type pattern_time = pattern_time_type::local);
    void set_formatter(formatter_ptr msg_formatter);

protected:
    const fmt::MemoryWriter* get_formatted_msg(const details::log_msg& msg, fmt::MemoryWriter& out);

private:
    level_t _level;
    formatter_ptr _formatter;

};

inline bool sink::should_log(level::level_enum msg_level) const
{
    return msg_level >= _level.load(std::memory_order_relaxed);
}

inline void sink::set_level(level::level_enum log_level)
{
    _level.store(log_level);
}

inline level::level_enum sink::level() const
{
    return static_cast<spdlog::level::level_enum>(_level.load(std::memory_order_relaxed));
}

inline void sink::set_pattern(const std::string& pattern, pattern_time_type pattern_time)
{
    _formatter = std::make_shared<pattern_formatter>(pattern, pattern_time);
}
inline void sink::set_formatter(formatter_ptr msg_formatter)
{
    _formatter = msg_formatter;
}

inline const fmt::MemoryWriter* sink::get_formatted_msg(const details::log_msg& msg, fmt::MemoryWriter& out)
{
    if (_formatter == nullptr)
    {
        return &msg.formatted;
    }
    else
    {
        _formatter->write_formated(msg, out);
        return &out;
    }
}

}
}

