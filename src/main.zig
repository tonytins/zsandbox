const std = @import("std");
const clap = @import("clap");

const debug = std.debug;
const io = std.io;
const process = std.process;

pub fn main() !void {
    const stdout = io.getStdOut().writer();

    var square: u8 = 1;
    var increment: u8 = 3;
    for (1..101) |door| {
        if (door == square) {
            try stdout.print("Door {d} is open\n", .{door});
            square += increment;
            increment += 2;
        }
    }
}

test "simple test" {
    var list = std.ArrayList(i32).init(std.testing.allocator);
    defer list.deinit(); // try commenting this out and see if zig detects the memory leak!
    try list.append(42);
    try std.testing.expectEqual(@as(i32, 42), list.pop());
}
