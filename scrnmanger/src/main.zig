const std = @import("std");
const rl = @import("raylib");

pub fn main() !void {
    // Init
    const screenWidth = 800;
    const screenHeight = 450;

    rl.initWindow(screenWidth, screenHeight, "Space Journey");
    defer rl.closeWindow();

    // Main game loop
    while (!rl.windowShouldClose()) {
        // Update

        // Draw
    }
}

test "simple test" {
    var list = std.ArrayList(i32).init(std.testing.allocator);
    defer list.deinit(); // try commenting this out and see if zig detects the memory leak!
    try list.append(42);
    try std.testing.expectEqual(@as(i32, 42), list.pop());
}
