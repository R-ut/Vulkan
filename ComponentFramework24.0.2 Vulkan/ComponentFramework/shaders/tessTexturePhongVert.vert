#version 450
#extension GL_ARB_separate_shader_objects : enable

// Inputs from vertex buffer
layout(location = 0) in vec4 vVertex;
layout(location = 1) in vec3 vNormal;
layout(location = 2) in vec2 uvCoord;

// Uniform block for matrices
layout(set = 0, binding = 0) uniform Matrices {
    mat4 projectionMatrix;
    mat4 viewMatrix;
    mat4 modelMatrix;
};

// Outputs to the tessellation control shader
layout(location = 0) out vec2 uvCoordFromVert;
layout(location = 1) out vec3 normalFromVert;
layout(location = 2) out float vertDistance;

void main() {
    // Pass through attributes to the tessellation control shader
    uvCoordFromVert = uvCoord;
    normalFromVert = vNormal;

    // Compute vertex distance for LOD (Level of Detail)
    vertDistance = length(viewMatrix * modelMatrix * vVertex);

    // Transform vertex position to clip space
    gl_Position = projectionMatrix * viewMatrix * modelMatrix * vVertex;
}
