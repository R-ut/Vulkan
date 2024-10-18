#version 450
#extension GL_ARB_separate_shader_objects : enable
const int NUM_LIGHTS = 3;
layout(binding = 1) uniform GlobalLightingUBO {
    vec4 position[NUM_LIGHTS];
    vec4 diffuse[NUM_LIGHTS];
    vec4 specular[NUM_LIGHTS];
    vec4 ambient;
} glights;

layout (location = 0) in vec3 vertNormal;
layout (location = 1) in vec3 lightDir[NUM_LIGHTS];
layout (location = 4) in vec3 eyeDir;
layout (location = 5) in vec2 fragTexCoords;

layout (location = 0) out vec4 fragColor;

layout(binding = 2) uniform sampler2D texSampler;

void main() { 
    
    vec4 fragColorAccum = vec4(0.0,0,0,0);
    vec4 kt = texture(texSampler, fragTexCoords);
    for (int i = 0; i < NUM_LIGHTS; i++) {
        
        
        
        float diff = max(dot(vertNormal, lightDir[i]), 0.0);
        vec4 diffuse = glights.diffuse[i]* diff * kt;
        /// Reflection is based on the incident beam of light which means a vector 
        /// from the light source, not the direction to the light source. 
        /// Put a minus sign on lightDir to turn it in the opposite direction. 
        vec3 reflection = normalize(reflect(-lightDir[i], vertNormal));

        float spec = max(dot(eyeDir, reflection), 0.0);
        spec = pow(spec, 4.0);
        vec4 specular = glights.specular[i] * spec * kt;
        
        fragColorAccum += diffuse + specular;
    }
    //vec4 ka = glights.ambient * kt ;
    fragColor = fragColorAccum ;
} 

