const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .name = "raylib-example",
        .target = target,
        .link_libc = true,
        .optimize = optimize,
    });

    exe.addCSourceFile(.{ .file = b.path("src/main.cpp") });
    exe.addIncludePath(b.path("include"));

    const raylib = b.dependency("raylib", .{});
    exe.linkLibrary(raylib.artifact("raylib"));
    exe.linkLibCpp();

    b.installArtifact(exe);

    const run = b.addRunArtifact(exe);
    b.step("run", "Run the app").dependOn(&run.step);
}
