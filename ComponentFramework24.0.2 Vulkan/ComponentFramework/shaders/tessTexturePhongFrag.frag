#version 450
#extension GL_ARB_separate_shader_objects : enable

const int NUM_LIGHTS = 3;

layout(binding = 1) uniform GlobalLightingUBO {
    vec4 position[NUM_LIGHTS];
    vec4 diffuse[NUM_LIGHTS];
    vec4 specular[NUM_LIGHTS];
    vec4 ambient;
} glights;

layout(location = 0) in vec3 fragNormal;
layout(location = 1) in vec2 fragTexCoords;
layout(location = 2) flat in uint fragTextureIndex;

layout(location = 0) out vec4 fragColor;

layout(binding = 2) uniform sampler2D texSampler[2]; // Texture array with two elements

void main() {
    vec4 kt = texture(texSampler[fragTextureIndex], fragTexCoords); // Sample texture
    fragColor = kt;  // Apply lighting or further processing if needed
}
