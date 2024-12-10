#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(vertices = 3) out;

layout(location = 0) in vec3 inPosition[];
layout(location = 1) in vec3 inNormal[];
layout(location = 2) in vec2 inTexCoords[];
layout(location = 3) flat in uint inTextureIndex[];

layout(location = 0) out vec3 outPosition[];
layout(location = 1) out vec3 outNormal[];
layout(location = 2) out vec2 outTexCoords[];
layout(location = 3) flat out uint outTextureIndex[];

void main() {
    // Pass through attributes
    outPosition[gl_InvocationID] = inPosition[gl_InvocationID];
    outNormal[gl_InvocationID] = inNormal[gl_InvocationID];
    outTexCoords[gl_InvocationID] = inTexCoords[gl_InvocationID];
    outTextureIndex[gl_InvocationID] = inTextureIndex[gl_InvocationID];

    // Set tessellation levels (e.g., static values or computed dynamically)
    if (gl_InvocationID == 0) {
        gl_TessLevelInner[0] = 5.0;
        gl_TessLevelOuter[0] = 5.0;
        gl_TessLevelOuter[1] = 5.0;
        gl_TessLevelOuter[2] = 5.0;
    }
}
