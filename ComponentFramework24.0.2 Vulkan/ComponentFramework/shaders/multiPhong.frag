#version 450
#extension GL_ARB_separate_shader_objects : enable

const int NUM_LIGHTS = 3;

layout(binding = 1) uniform GlobalLightingUBO {
    vec4 position[NUM_LIGHTS];
    vec4 diffuse[NUM_LIGHTS];
    vec4 specular[NUM_LIGHTS];
    vec4 ambient;
} glights;

layout(location = 0) in vec3 vertNormal;
layout(location = 1) in vec3 lightDir[NUM_LIGHTS];
layout(location = 4) in vec3 eyeDir;
layout(location = 5) in vec2 fragTexCoords;
layout(location = 6) flat in uint fragTextureIndex;

layout(location = 0) out vec4 fragColor;

layout(binding = 2) uniform sampler2D texSampler[2]; // Texture array with two elements

layout(push_constant) uniform Push {
    mat4 modelMatrix;
    mat4 normalMatrix;
    uint textureIndex;
} push;

void main() {
    vec4 fragColorAccum = vec4(0.0, 0.0, 0.0, 0.0);
    vec4 kt = texture(texSampler[fragTextureIndex], fragTexCoords); // Sample from the texture array using the index

    for (int i = 0; i < NUM_LIGHTS; i++) {
        float diff = max(dot(vertNormal, lightDir[i]), 0.0);
        vec4 diffuse = glights.diffuse[i] * diff * kt;

        vec3 reflection = normalize(reflect(-lightDir[i], vertNormal));
        float spec = max(dot(eyeDir, reflection), 0.0);
        spec = pow(spec, 4.0);
        vec4 specular = glights.specular[i] * spec * kt;

        fragColorAccum += diffuse + specular;
    }

    // You can uncomment the following line if you want to add ambient lighting
    // vec4 ka = glights.ambient * kt;

    fragColor = fragColorAccum;
}
