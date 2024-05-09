const std = @import("std");
const io = std.io;
const rl = @import("raylib");

/// https://rosettacode.org/wiki/Tokenize_a_string#Zig
pub fn tokenize() void {
    const string = "Hello,How,Are,You";
    var tokens = std.mem.split(u8, string, ",");
    std.debug.print("{s}\n", .{tokens.next().?});
    while (tokens.next()) |token| {
        std.debug.print(".{s}\n", .{token});
    }
}

/// https://rosettacode.org/wiki/Draw_a_cuboid#Zig
pub fn cube() !void {
    rl.initWindow(600, 480, "Cubes");
    defer rl.closeWindow();

    const camera = rl.Camera3D{
        .position = rl.Vector3.init(4.5, 4.5, 4.5),
        .target = rl.Vector3.init(0, 0, 0),
        .up = rl.Vector3.init(0, 1, 0),
        .fovy = 45,
        .projection = rl.CameraProjection.camera_perspective,
    };

    while (!rl.windowShouldClose()) {
        rl.beginDrawing();
        defer rl.endDrawing();

        rl.clearBackground(rl.Color.black);

        camera.begin();
        defer camera.end();

        rl.drawCubeWires(rl.Vector3.init(0, 0, 0), 2, 3, 4, rl.Color.lime);
    }
}
