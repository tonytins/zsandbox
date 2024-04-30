const std = @import("std");
const rl = @import("raylib");

const MAX_COLUMNS = 20;

pub fn main() !void {
    const screenWidth = 800;
    const screenHeight = 450;

    rl.initWindow(screenWidth, screenHeight, "Space Journey");
    defer rl.closeWindow();

    var camera = rl.Camera3D{ .position = rl.Vector3.init(4, 2, 4), .target = rl.Vector3.init(0, 1.8, 0), .up = rl.Vector3.init(0, 1, 0), .fovy = 60, .projection = rl.CameraProjection.camera_perspective };

    var heights: [MAX_COLUMNS]f32 = undefined;
    var positions: [MAX_COLUMNS]rl.Vector3 = undefined;
    var colors: [MAX_COLUMNS]rl.Color = undefined;

    for (0..heights.len) |i| {
        heights[i] = @as(f32, @floatFromInt(rl.getRandomValue(1, 12)));
        positions[i] = rl.Vector3.init(@as(f32, @floatFromInt(rl.getRandomValue(-15, 15))), heights[i] / 2.0, @as(f32, @floatFromInt(rl.getRandomValue(-15, 15))));
        colors[i] = rl.Color.init(@as(u8, @intCast(rl.getRandomValue(20, 255))), @as(u8, @intCast(rl.getRandomValue(10, 255))), 20, 255);
    }

    rl.disableCursor();
    rl.setTargetFPS(60);

    while (!rl.windowShouldClose()) {
        camera.update(rl.CameraMode.camera_first_person);

        rl.beginDrawing();
        defer rl.endDrawing();

        rl.clearBackground(rl.Color.ray_white);

        {
            camera.begin();
            defer camera.end();

            rl.drawPlane(rl.Vector3.init(0, 0, 0), rl.Vector2.init(32, 32), rl.Color.light_gray);
            rl.drawCube(rl.Vector3.init(-16, 2.5, 0), 1.0, 5.0, 32.0, rl.Color.blue);
            rl.drawCube(rl.Vector3.init(16.0, 2.5, 0), 1.0, 5.0, 32.0, rl.Color.lime);
            rl.drawCube(rl.Vector3.init(0, 2.5, 16.0), 32.0, 5.0, 1.0, rl.Color.gold);

            for (heights, 0..) |height, i| {
                rl.drawCube(positions[i], 2.0, height, 2.0, colors[i]);
                rl.drawCubeWires(positions[i], 2.0, height, 2.0, rl.Color.maroon);
            }
        }

        rl.drawRectangle(10, 10, 220, 70, rl.Color.sky_blue.fade(0.5));
        rl.drawRectangleLines(10, 10, 228, 70, rl.Color.blue);

        rl.drawText("First person camera default controls:", 20, 20, 10, rl.Color.black);
        rl.drawText("- Move with keys: W, A, S, D", 40, 40, 10, rl.Color.dark_gray);
        rl.drawText("- Mouse move to look around", 40, 60, 10, rl.Color.dark_gray);
    }
}
