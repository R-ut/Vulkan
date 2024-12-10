#version 450
#extension GL_ARB_separate_shader_objects : enable

const int NUM_LIGHTS = 3;

layout(location = 0) in vec4 vVertex;
layout(location = 1) in vec4 vNormal;
layout(location = 2) in vec2 texCoords;

layout(binding = 0) uniform CameraUBO {
    mat4 projectionMatrix;
    mat4 viewMatrix;
} camera;

layout(push_constant, std140) uniform Push {
    mat4 modelMatrix;
    mat3x4 normalMatrix;
    uint textureIndex;
} push;

layout(location = 0) out vec3 outPosition;   // Pass to TCS
layout(location = 1) out vec3 outNormal;     // Pass to TCS
layout(location = 2) out vec2 outTexCoords;  // Pass to TCS
layout(location = 3) flat out uint outTextureIndex; // Flat qualifier to avoid interpolation

void main() {
    // Compute world-space position and normal
    mat3 normalMatrix = mat3(push.normalMatrix);
    outPosition = vec3(push.modelMatrix * vVertex);
    outNormal = normalize(normalMatrix * vNormal.xyz);

    // Pass texture coordinates and index
    outTexCoords = texCoords;
    outTextureIndex = push.textureIndex;

    // Compute final position in clip space
    gl_Position = camera.projectionMatrix * camera.viewMatrix * push.modelMatrix * vVertex;
}
