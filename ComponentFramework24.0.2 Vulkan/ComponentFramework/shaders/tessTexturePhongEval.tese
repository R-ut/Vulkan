#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(triangles, equal_spacing, ccw) in;

layout(location = 0) in vec3 inPosition[];
layout(location = 1) in vec3 inNormal[];
layout(location = 2) in vec2 inTexCoords[];
layout(location = 3) flat in uint inTextureIndex[];

layout(location = 0) out vec3 fragNormal;  // Pass to FS
layout(location = 1) out vec2 fragTexCoords; // Pass to FS
layout(location = 2) flat out uint fragTextureIndex; // Pass to FS

void main() {
    // Interpolate attributes
    vec3 position = gl_TessCoord.x * inPosition[0] +
                    gl_TessCoord.y * inPosition[1] +
                    gl_TessCoord.z * inPosition[2];

    fragNormal = normalize(gl_TessCoord.x * inNormal[0] +
                           gl_TessCoord.y * inNormal[1] +
                           gl_TessCoord.z * inNormal[2]);

    fragTexCoords = gl_TessCoord.x * inTexCoords[0] +
                    gl_TessCoord.y * inTexCoords[1] +
                    gl_TessCoord.z * inTexCoords[2];

    fragTextureIndex = inTextureIndex[0]; // Assume all indices are the same

    gl_Position = vec4(position, 1.0);
}
